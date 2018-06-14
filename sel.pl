#!/usr/bin/perl -w

use	strict;

use	utf8;
use	Encode	qw/decode encode/;


while (<>){
	chomp;
	my	$title	=	(split(/:/,decode('utf-8',$_)))[2];
	
	# 検索用文字列
	my	$title_trim	=	$title;
	
	$title_trim	=~	s/\s//g;	# 空白は除去
	
	$title_trim	=~	s/^\d{4}年(?:代|以降|)(?:の|に)//; # 先頭の「2010年代の」などは除去
	
	$title_trim	=~	s/\([^)]+\)$//; # 末尾の「(...)」は除去
	
	$title_trim	=~	s/\d+$//;	# 末尾の数字列は除去
		
	# ↓↓読み飛ばし
	next
		if	$title_trim	=~	/の一覧/;
	next
		if	$title	=~	/一覧\s/;
	next
		if	$title	=~	/一覧$/;
	next
		if	$title	=~	/\s最近の出来事\s/;
	next
		if	$title_trim	=~	/^\d{4}年-\d{4}年の/;
	next
		if	$title_trim	=~	/^\d{4}年[\p{Han}\p{Katakana}ー・]+オリンピックの/;
	
	next
		if	$title_trim	=~	/^\d{4}年.*における.*競技$/;
	
	# ↑↑読み飛ばし
	
	my	$flg	=	{
		SUJI	=>	0,
		ALPHA	=>	0,
		HIRA	=>	0,
		KATA	=>	0,
		KANJI	=>	0,
		GREEK	=>	0,
		OTHER	=>	0,
	};
	
	$flg->{SUJI}	=	1
		if	$title_trim	=~	/[0-9]/
		||	$title_trim	=~	/[０-９]/;
	
	$flg->{ALPHA}	=	1
		if	$title_trim	=~	/[A-Za-z]/
		||	$title_trim	=~	/[Ａ-Ｚａ-ｚ]/;
	
	$flg->{HIRA}	=	1
		#if	$title_trim	=~	/[あ-ん]/;
		if	$title_trim	=~	/\p{Hiragana}/;
	
	$flg->{KATA}	=	1
		if	$title_trim	=~	/\p{Katakana}/;
	
	$flg->{KANJI}	=	1
		if	$title_trim	=~	/\p{Han}/;
	
	$flg->{KANJI}	=	1
		if	$title_trim	=~	/\p{Han}/;
	
	$flg->{GREEK}	=	1
		if	$title_trim	=~	/\p{Greek}/;
	
	my	$cnt	=	0;
	{
		local	$_;
		$cnt++	for	grep $flg->{$_}, keys(%$flg);
	}
	printf("%d:%s\n",length($title),encode('utf8',$title))
		if	$cnt	>=	4;
		
}
