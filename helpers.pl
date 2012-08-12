#!/usr/bin/perl

use utf8;
use Image::BMP;
use Image::Magick;
use File::Basename;

my $data;
my $width, $height;

#read all possible file in the folder.
sub readFolder(){
	if ($_[0] eq undef){
		print 'Folder path requred.'."\n";
		return;
	}
	if ($_[1] eq undef){$_[1] = 'pgm';}
	my $count = 1;
	opendir(DIR, $_[0]);
	while(my $file = readdir(DIR)){
		if ($file ne "." && $file ne ".."){
			&image2PGM($_[0].'/'.$file, $_[1], $count++);
		}
	}
}

#reading the BMP file and return an array of gray-scale pixels
#param 0: file path.
sub readFile(){
	eval{
		my $image = new Image::Magick;
		$image->Read($_[0]);
		$width  = $image->Get('width');
		$height = $image->Get('height');
		@data = $image->GetPixels(map=>'I', height=>$height, width=>$width, normalize=>true);
		my $count = 0;
		foreach $p (@data){
			$p = int($p * 255);
		}
	};
	if ($@){
		print "$@";
	}
	$data;
}

#read no-comments PGM file only.
#this is for simple and fast.
#It's error if there's comment.
sub readPGM(){
	if ($_[0] eq undef){
		print "File name required.\n";
		return;
	}
	#try to open file.
	open(FILE, '<'.$_[0]) or die ("Unable to open file.");
	#ignore the first line.
	my $line = <FILE>;
	#read size
	$line = <FILE>;
	chomp($line);
	my ($width, $height) = qw("$line");
	
	$line = <FILE>;
	my $color = chomp($line); #read color range.
	print "$width - $height - $color\n";
}

sub image2PGM(){
	if ($_[0] eq undef || $_[1] eq undef){
		print "2 params required.\n";
		return;
	}
	&readFile($_[0]);
	if (scalar(@data) <= 0){
		return;
	}
	
	my ($name, $dir) = fileparse $_[0];
	eval {mkdir($_[1]);};
	
	if ($_[2] ne undef){$name = $_[2];}
	
	my $output = $_[1] . '/' . $name . '.pgm';
	#check if file exists, pick another name.
	if (-e $output) { $output = $_[1] . '/' . $name.'_cp.pgm';}
	
	open(imageFile, ">".$output) || die ('cannot write file.');
	print imageFile 'P2'."\n$width $height\n255\n";
	foreach $x (0..$width-1){
		foreach $y (0..$height-1){
			$val = shift(@data);
			print imageFile "$val ";
		}
		print imageFile "\n";
	}
	close(imageFile);
	print $name . " converted to PGM.\n";
}

sub writePGM(){
	if ($_[0] eq undef){
		print "File name required.\n"; return;
	}
	if (scalar(@data) < 1) {print "Nothing to write."; return;}
	
	my ($name, $dir) = fileparse $_[0];
	eval {mkdir($dir);};
	if (-e $_[0]){ $_[0] = $dir . "cp_".$name;}
	
	open(imageFile, ">".$_[0]) || die ('cannot write file.');
	print imageFile 'P2'."\n$width $height\n255\n";
	foreach $x (0..$width-1){
		foreach $y (0..$height-1){
			$val = shift(@data);
			print imageFile "$val ";
		}
		print imageFile "\n";
	}
	close(imageFile);
}

sub bmp2pgm {
	
}

sub pgm2features {
	if ($_[0] eq undef || $_[1] eq undef){
		print "Params required.\n";
		return;
	}
	if ($_[0] > $_[1]) {print "Invalid params"; return;}
	
	foreach $p (@data){
		if ($p < $_[0] || $p > $_[1]){ $p = 255;}
	}
	$data;
}
return true;
