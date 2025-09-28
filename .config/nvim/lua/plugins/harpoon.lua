return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
    { "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
    { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Go to Harpoon file 1" },
    { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Go to Harpoon file 2" },
    { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Go to Harpoon file 3" },
    { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Go to Harpoon file 4" },
    { "<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "Go to Harpoon file 5" },
  },
}

