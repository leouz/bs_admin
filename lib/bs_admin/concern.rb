require 'active_support/concern'

module BsAdmin::Concern
  extend ActiveSupport::Concern
 
  def bs_admin &block
    if class_variable_defined?("@@meta")
      meta = class_variable_get("@@meta")
    else
      m = BsAdmin::MetaBuilder.new(self)
      yield(m)
      meta = m.build
      class_variable_set("@@meta", meta)
    end

    m = meta
    m.fields.each do |f|
      attr_accessible f.name
      mount_uploader(f.name, "#{m.name}#{f.name.to_s.camelize}Uploader".constantize) if f.type == :image or f.type == :file
      monetize "#{f.name}_cents" if f.type == :money
    end

    required_fields = m.fields.select{|f| !!f.options[:required] }.map{|f| f.name}
    validates_presence_of required_fields if required_fields.any?

    m.relationships.each do |r|
      if [:has_many, :has_one].include? r.type
        has_many r.field, r.class_declaration_options if r.type == :has_many
        has_one r.field, r.class_declaration_options if r.type == :has_one
        accepts_nested_attributes_for r.field, allow_destroy: true
      end
      belongs_to r.field, r.class_declaration_options if r.type == :belongs_to
    end

    paginates_per m.page_size if m.page_size

    include BsAdmin
  end

  included do |base|
  end

  module ClassMethods
    def meta
      class_variable_get("@@meta")
    end
  end 
end

ActiveRecord::Base.extend(BsAdmin::Concern)
ActiveRecord::Base.send(:include, BsAdmin::Concern)