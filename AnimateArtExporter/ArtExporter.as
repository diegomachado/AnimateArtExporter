﻿package AnimateArtExporter
{	
	import by.blooddy.crypto.image.PNGEncoder;
	import AnimateArtExporter.animation.AnimationData;
	import AnimateArtExporter.animation.AssetSheet;
	import AnimateArtExporter.spritesheet.Spritesheet;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	public class ArtExporter
	{
		public static var swfName:String;
		
		var _animationData:AnimationData;
		var _assetSheet:AssetSheet;
		var _spriteSheet:Spritesheet;
		
		var _movieClip:MovieClip;
		var _padding:uint;
		var _transparentBackground:Boolean;
		var _scalesToExport:Array;

		public function init(root:DisplayObjectContainer, config:ArtExporterConfig)
		{
			var swf = root.loaderInfo.url;
			swf = swf.slice(swf.lastIndexOf("/") + 1);
			swf = swf.slice(0, swf.indexOf("."));
			swfName = swf;
			
			_movieClip = config.movieClip;
			_padding = config.padding;
			_transparentBackground = config.transparentBackground;
			_scalesToExport = config.scalesToExport;
			
			_animationData = new AnimationData();
			_assetSheet = new AssetSheet();
			_spriteSheet = new Spritesheet();
		}
		
		public function exportAssetSheet()
		{
			for(var scaleId in _scalesToExport)
				_assetSheet.export(_movieClip, _scalesToExport[scaleId], _padding, _transparentBackground);
		
			_animationData.export(_movieClip, _assetSheet.getSpritesheetData());
		}
		
		public function exportSpriteSheet()
		{
			for(var scaleId in _scalesToExport)
				_spriteSheet.export(_movieClip, _scalesToExport[scaleId], _padding, _transparentBackground);
		}
	}
}