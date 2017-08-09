class AddAvatarToAuthors < ActiveRecord::Migration[5.0]

  def up
    add_attachment :authors, :avatar
  end

  def down
    remove_attachment :authors, :avatar
  end

end
