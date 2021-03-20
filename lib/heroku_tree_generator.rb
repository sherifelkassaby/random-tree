class HerokuTreeGenerator
  HEROKU_APP_URL = ENV['HEROKU_TREE_GENERATOR_URL'] || 'https://random-tree.herokuapp.com'

  def self.perform
    resp = HTTP.get(HEROKU_APP_URL)

    if resp.code == 200
      OpenStruct.new(success?: true, tree: JSON.parse(resp.body))
    else
      OpenStruct.new(success?: false, errors: JSON.parse(resp.body)["error_description"])
    end

  rescue StandardError => e
    OpenStruct.new(success?: false, errors: e.message)
  rescue HTTP::TimeoutError
    OpenStruct.new(success?: false, errors: 'Heroku app connection timeout')
  end
end
