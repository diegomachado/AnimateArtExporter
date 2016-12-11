﻿package AnimateArtExporter 
{
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import treefortress.textureutils.MaxRectPacker;
	
	public class MaxRectSolver 
	{
		var _rectangles:Object;
		var _size:int;
		
		function MaxRectSolver(mc:MovieClip, bitmapDatas:Object)
		{
			_rectangles = {};
			_size = 0;
			solve(mc, bitmapDatas);
		}
		
		function solve(mc:MovieClip, bitmapDatas:Object)
		{
			var rectangles = {};
			
			var pow2Sizes = [128, 256, 512, 1024, 2048];
			var pow2Sheet:BitmapData;
			var packer:MaxRectPacker;
			
			var bitmapDatasLength = Utils.mapSize(bitmapDatas);
			
			for(var sizeId:int = 0; sizeId < pow2Sizes.length; ++sizeId)
			{
				rectangles = [];
				var pow2Size = pow2Sizes[sizeId];
				var fittedRectangles = 0;
				
				packer = new MaxRectPacker(pow2Size, pow2Size);
				
				for(var bitmapDataId in bitmapDatas)
				{
					var bitmapData = bitmapDatas[bitmapDataId];
					var fittedRectangle = packer.quickInsert(bitmapData.width, bitmapData.height);
					
					if(!fittedRectangle)
						break; 
					
					rectangles[bitmapDataId] = fittedRectangle;
					fittedRectangles++;
				}
			
				if(fittedRectangles == bitmapDatasLength)
				{
					_rectangles = rectangles;
					_size = pow2Size;
					break;
				}
			}
		}
		
		public function getRectangles()
		{
			return (Utils.mapSize(_rectangles) > 1) ? _rectangles : [];
		}
		
		public function getSize()
		{
			return _size;
		}
	}
}