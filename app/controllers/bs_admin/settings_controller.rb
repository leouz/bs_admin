# -*- encoding : utf-8 -*-
class BsAdmin::SettingsController < BsAdminLoggedControllerBase
  def index
    key = params[:key] ? params[:key] : BsAdmin::SettingGroup.first.key
    @group = BsAdmin::SettingGroup.find_by_key key
    @strings = @group.strings.order :display_name
    @texts = @group.texts.order :display_name
    @booleans = @group.booleans.order :display_name
  end

  def edit
    @type = params[:type]
    @group_key = params[:group_key]
    @setting = BsAdmin::SettingGroup.find_by_key(@group_key).settings(@type).find_by_key(params[:key])
  end

  def update
    setting = BsAdmin::SettingGroup.find_by_key(params[:group_key]).settings(params[:type]).find_by_id(params[:id])

    respond_to do |format|
      if setting.update_attributes(params["#{params[:type]}_setting"])
        setting.has_user_changed = true
        setting.save!
        format.html { redirect_to bs_admin.settings_group_path(params[:group_key]), notice: 'Setting was successfully updated.' }
      else
        format.html { render action: :edit }
      end
    end
  end
end
