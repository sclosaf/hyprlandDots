return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>ar", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
    { "<leader>hr", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
    { "<leader>r1", function() require("harpoon.ui").nav_file(1) end, desc = "Go to Harpoon file 1" },
    { "<leader>r2", function() require("harpoon.ui").nav_file(2) end, desc = "Go to Harpoon file 2" },
    { "<leader>r3", function() require("harpoon.ui").nav_file(3) end, desc = "Go to Harpoon file 3" },
    { "<leader>r4", function() require("harpoon.ui").nav_file(4) end, desc = "Go to Harpoon file 4" },
    { "<leader>r5", function() require("harpoon.ui").nav_file(5) end, desc = "Go to Harpoon file 5" },
    { "<leader>r6", function() require("harpoon.ui").nav_file(6) end, desc = "Go to Harpoon file 6" },
    { "<leader>r7", function() require("harpoon.ui").nav_file(7) end, desc = "Go to Harpoon file 7" },
    { "<leader>r8", function() require("harpoon.ui").nav_file(8) end, desc = "Go to Harpoon file 8" },
    { "<leader>r9", function() require("harpoon.ui").nav_file(9) end, desc = "Go to Harpoon file 9" },
  },
}

