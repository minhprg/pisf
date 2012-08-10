#!/usr/bin/perl

use utf8;
use Image::BMP;
use Image::Magick;

my $data;
my $width, $height;
#reading the BMP file and return an array of gray-scale pixels
#param 0: file path.
sub readBMP{
	my $image = new Image::BMP;
	$image->open_file($_[0]);
	$width  = $image->{Width};
	$height = $image->{Height};
	#loop to get all image
	foreach $x (0..$width-1){
		foreach $y (0..$height-1){
			#get RGB and convert to grayscale.
			my ($r, $g, $b) = $image->xy_rgb($x, $y);
			push(@data, &rgb2gray($r, $g, $b));
		}
	}
	$data;
}

sub readFile(){
	my $image = new Image::Magick;
	$image->Read($_[0]);
	$width  = $image->Get('width');
	$height = $image->Get('height');
	print "Width : $width\n";
	print "Height: $height\n";
}

sub rgb2gray{
	$return = int(0.2989 * $_[0] + 0.5870 * $_[1] + 0.1140 * $_[2] + 0.5);
}

sub bmp2pgm {
	&readBMP($_[0]);
}

sub pgm2features {
	
}
return true;
