module Trees
  class PopulateTreeNodesService
    include ServiceLoader

    def initialize(nodes_list:)
      @nodes_list = nodes_list
    end

    def run
      populate_tree_hash
    end

    private

    attr_reader :nodes_list

    def populate_tree_hash
      parent_node = nodes_list.select { |node| node.depth == 1 }.first

      @tree_hash = { id: parent_node.node_id, child: [] }.with_indifferent_access

      create_child_hash(nodes_list: nodes_list, child_depth: 2)

      @tree_hash
    end

    def create_child_hash(nodes_list:, child_depth:)
      child_nodes = nodes_list.select { |node| node.depth == child_depth }
      return if child_nodes.empty?

      child_nodes.map do |node|
        ancestors_ids = node.path.split('/')
        ancestor_child_arr = @tree_hash['child']

        # search and select current node's parent child array
        ancestors_ids.each_with_index do |ancestor_id, i|
          # select the parent hash path, skip the first ancestor node as it was populated before in the hash,
          # skip current node as it is not needed atm.
          next if [0, child_depth - 1].include?(i)

          ancestor_child_arr = ancestor_child_arr.select { |ancestor| ancestor['id'] == ancestor_id }.first['child']
        end

        ancestor_child_arr << { id: node.node_id, child: [] }.with_indifferent_access
      end

      create_child_hash(nodes_list: nodes_list, child_depth: child_depth + 1)
    end
  end
end