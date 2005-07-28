Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 035A167DA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 20:08:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=gb2312
Date: Thu, 28 Jul 2005 18:08:42 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86504A@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: "Esben Nielsen" <simlo@phys.au.dk>, "Frank" <frannk_m1@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: =?gb2312?b?tPC4tDogSG93IHRvIGxvYWQgYSBsaW51eCBrZXJuZWwgdW5kZXIg?=
	=?gb2312?b?dnh3b3JrcyBib290bG9hZGVyIChQUEM4NjBib2FyZCk=?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Esben:
 Thanks for your advice. I guess the vxworks 5.3.1 can process the ELF =
format.=20
 Can you tell me "the link address of the VxWorks kernel ELF file" ?=20
 Someone said that  "make sure the Linux kernel is linked at that same =
address".
 Other one said to use zImage of kernel instead of ELF "vmlinux" image, =
have you tested using zImage on vxWorks?=20
=20
  Can you give me some step  tips when processing your 5.5 bootloader ?
  need to revise the entry points? using the 0x200000 original addresss =
of linux kernel ?=20
  The serial port print what info after "starting at 0x200000 ...." ?=20
 =20
  thanks a lot!
 =20

-----=D4=AD=CA=BC=D3=CA=BC=FE-----
=B7=A2=BC=FE=C8=CB: Esben Nielsen [mailto:simlo@phys.au.dk]
=B7=A2=CB=CD=CA=B1=BC=E4: 2005=C4=EA7=D4=C228=C8=D5 15:47
=CA=D5=BC=FE=C8=CB: Frank
=B3=AD=CB=CD: FCG WANG Baohua; linuxppc-embedded@ozlabs.org
=D6=F7=CC=E2: Re: How to load a linux kernel under vxworks bootloader
(PPC860board)


On Wed, 27 Jul 2005, Frank wrote:

>=20
>=20
> --- FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn> wrote:
>=20
> > Dear All:
> >   I want to boot a linux 2.4.25 kernel under vxworks
> > bootloader. When I using flat mode(0x200000 -->  0x10000)
> > kernel  uncompressed ELF format ( vmlinux ),
> >  and download it using TFTP of vxworks, it print the "starting
> > at 0x1000 ...." and  freeze.  No input or output on serial
> > port.
> >  The version of vxworks is 5.3.1.=20
> >  can you give me some detail advice or give me a tool to slove
> > it? thanks !

I have done it on a MPC5200 with a vxWorks 5.5 bootsector with ethernet
support: I just boot over FTP.  Give it the Linux kernel in elf-format,=20
the bootsector doesn't care, _what_ the code actually is, it just loads
and run it.=20

For vxWorks <=3D 5.4 I believe coff is used instead of elf - at least on
some architectures. Then you have a problem, because the kernel isn't
compiled to coff :-(

Esben


>=20
> Do what I did:
> Replace the vxWorks rom with you u-boot and you can boot Linux
> or vxWorks with the same bootloader.
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around=20
> http://mail.yahoo.com=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
