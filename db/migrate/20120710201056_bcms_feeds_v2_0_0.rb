class BcmsFeedsV200 < ActiveRecord::Migration
  def change
    if table_exists?(:feeds) && !table_exists?(:bcms_feeds_feeds)
      rename_table :feeds, :bcms_feeds_feeds
    end
  end
end
