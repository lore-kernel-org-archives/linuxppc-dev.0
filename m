Message-ID: <2F67A63DFFB1D31185D90090278CBB2D02578BC9@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (A-China,ex1)" <hai-tao_zhang@agilent.com>
To: zjuzhou@163.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Who can tell me the detail of boot?
Date: Fri, 20 Apr 2001 18:54:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

You may find some usefule information on CHRP documentation and some
application notes from Motorola. And there are lots of documents introducing
Linux boot process. The vmlinuz file, you can check the linux Makefile for
very detailed information.

I do not think that you will get all you want if you ask so general and big
questions.

Haitao

> -----Original Message-----
> From: zjuzhou@163.net [mailto:zjuzhou@163.net]
> Sent: Friday, April 20, 2001 9:25 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Who can tell me the detail of boot?
>
>
>
> hello all,
>
> 	I can't understand the detail of boot,(my target borad
> is customed).
> From supply power,CPU reset then run instructs from
> flash,load vmlinuz image
> file to ram,vmlinuz image then do what? And what is the
> combination of of
> vmlinuz image file?
> 	thanks.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
