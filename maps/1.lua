return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 25,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 9,
  nextobjectid = 21,
  properties = {},
  tilesets = {
    {
      name = "Subway_tiles",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 25,
      image = "tileset/Subway_tiles.png",
      imagewidth = 400,
      imageheight = 400,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 625,
      tiles = {}
    },
    {
      name = "tiles_out",
      firstgid = 626,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 13,
      image = "tileset/tiles_out.png",
      imagewidth = 208,
      imageheight = 400,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 325,
      tiles = {}
    },
    {
      name = "RPGmob",
      firstgid = 951,
      tilewidth = 44,
      tileheight = 44,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "tileset/RPGmob.png",
      imagewidth = 440,
      imageheight = 44,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 44,
        height = 44
      },
      properties = {},
      wangsets = {},
      tilecount = 10,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 5,
      name = "bg",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 115, 116, 117, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 139, 140, 141, 142, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 283, 284, 285, 286, 287, 0, 0, 0, 0, 164, 165, 166, 167, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 308, 309, 310, 311, 312, 0, 0, 112, 0, 0, 0, 0, 0, 0,
        0, 0, 281, 282, 0, 0, 0, 137, 138, 0, 0, 333, 334, 335, 336, 337, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 306, 307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 331, 332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 66, 0, 0, 0, 188, 189, 0, 0, 61, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 91, 0, 0, 0, 213, 214, 0, 0, 0, 0, 0,
        0, 56, 33, 34, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 239, 0, 0, 0, 0, 0,
        0, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 106, 0, 114, 115, 116, 117, 56, 114, 115, 116, 117, 56, 114, 115, 116, 117, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 139, 140, 141, 142, 81, 139, 140, 141, 142, 81, 139, 140, 141, 142, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 164, 165, 166, 167, 106, 164, 165, 166, 167, 106, 164, 165, 166, 167, 0, 0, 0, 0, 0, 32, 0, 0,
        0, 0, 0, 0, 137, 138, 0, 0, 0, 137, 138, 0, 0, 137, 138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        149, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64, 0, 0,
        0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0,
        0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 192, 191, 192, 193, 194,
        0, 0, 0, 0, 0, 0, 147, 0, 0, 190, 191, 192, 193, 194, 195, 196, 196, 195, 195, 195, 215, 216, 217, 218, 0,
        0, 0, 0, 0, 0, 0, 147, 0, 0, 215, 216, 217, 218, 0, 0, 221, 222, 0, 0, 0, 240, 241, 242, 243, 0,
        5, 7, 8, 9, 10, 10, 11, 0, 0, 240, 241, 242, 243, 0, 0, 246, 247, 0, 0, 0, 265, 266, 317, 268, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 265, 266, 267, 268, 0, 0, 271, 272, 0, 0, 0, 290, 291, 292, 293, 0,
        0, 0, 0, 5, 10, 10, 10, 10, 10, 6, 6, 6, 7, 8, 3, 6, 11, 0, 0, 0, 315, 0, 0, 268, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 265, 266, 267, 268, 192,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 190, 191, 191, 192, 193,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 215, 0, 217, 218,
        49, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 0, 240, 0, 242, 243,
        74, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 28, 29, 0, 265, 0, 267, 268,
        143, 93, 94, 94, 94, 95, 93, 94, 94, 95, 93, 94, 94, 94, 95, 93, 94, 94, 94, 94, 94, 94, 94, 95, 100,
        168, 118, 119, 119, 119, 120, 118, 119, 119, 120, 118, 119, 119, 119, 120, 118, 119, 119, 119, 119, 119, 119, 119, 120, 125
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "solid",
      visible = true,
      opacity = 1,
      offsetx = 0.333333,
      offsety = 0.333333,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 98, 98, 98 },
      properties = {
        ["collidable"] = true
      },
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 370.667,
          width = 400,
          height = 29.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 52.2875,
          y = 275.17,
          width = 218.693,
          height = 11.178,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 4.66667,
          y = 242.333,
          width = 105.917,
          height = 12.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 272.786,
          y = 338.339,
          width = 46.125,
          height = 31.9507,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 383.786,
          y = 287.953,
          width = 16.3068,
          height = 15.428,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 321.945,
          y = 303.953,
          width = 77.9432,
          height = 15.428,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 145.958,
          y = 208.25,
          width = 141.917,
          height = 15.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 287.708,
          y = 191.5,
          width = 112.667,
          height = 15.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0.208167,
          y = 336,
          width = 30.417,
          height = 6.5833,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "enemies",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["enemySpawner"] = true
      },
      objects = {
        {
          id = 14,
          name = "",
          type = "",
          shape = "point",
          x = 206.125,
          y = 369.625,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["enemySpawner"] = true
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "point",
          x = 179.375,
          y = 273.625,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["enemySpawner"] = true
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "point",
          x = 58.875,
          y = 241.375,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["enemySpawner"] = true
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "point",
          x = 234.375,
          y = 208.625,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["enemySpawner"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "playerSpawner",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 20,
          name = "",
          type = "",
          shape = "point",
          x = 76,
          y = 344,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
