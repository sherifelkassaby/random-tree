module Tree
  class RandomGeneratorGateway
    def self.generate_random_tree
      HerokuTreeGenerator.perform
    end
  end
end