From: "Stefano Coluccini" <s.coluccini@caen.it>
To: <kingseft@samsung.co.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Question about making ramdisk for ppc
Date: Mon, 5 Mar 2001 13:02:31 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMMEKPCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <H00002af04a72993@MHS>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>  Hi developers!!
>
>  Now, I'm trying to make a ramdisk image for ppc on intel platform.
>  also, I read "The Linux Bootdisk Howto" and I knew the procedure
> of making ramdisk.
>
>  But I have one question about that!!
>  Our linux host system's CPU is Intel and I'd like to make a
> ramdisk for ppc
>
>  of course, I think the directories of linux host system are not
> suitable for ppc ramdisk..
>  Could you please exaplain or describe How to make ramdisk for
> ppc on Intel Platform...

The tree is the same; of course the executables must be for the ppc CPU so
you can obtain the binary from some ppc distribution or recompile the source
with your cross-compiler.

Bye.
Stefano.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
