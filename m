Return-Path: <simlo@phys.au.dk>
Received: from lirs02.phys.au.dk (lirs02.phys.au.dk [130.225.28.43])
	by ozlabs.org (Postfix) with ESMTP id 6532F67DB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 21:07:26 +1000 (EST)
Date: Thu, 28 Jul 2005 13:07:04 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E86504A@ydmail.sbell.com.cn>
Message-Id: <Pine.OSF.4.05.10507281259121.17491-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: =?gb2312?b?tPC4tDogSG93IHRvIGxvYWQgYSBsaW51eCBrZXJuZWwgdW5k?=
 =?gb2312?b?ZXIgdnh3b3JrcyBib290bG9hZGVyIChQUEM4NjBib2FyZCk=?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 28 Jul 2005, FCG WANG Baohua wrote:

> Dear Esben:
>  Thanks for your advice. I guess the vxworks 5.3.1 can process the ELF fo=
rmat.=20
>  Can you tell me "the link address of the VxWorks kernel ELF file" ?=20
>  Someone said that  "make sure the Linux kernel is linked at that same ad=
dress".
>  Other one said to use zImage of kernel instead of ELF "vmlinux" image, h=
ave you tested using zImage on vxWorks?=20
>
I used the compressed elf image. I lost my HD since so I can't find it
now, but I think it was called arch/ppc/boot/zImage.elf or something like
that. It is around 1+-0.4 Mb big. Use the file command to check wether it
is elf or not.

 =20
>   Can you give me some step  tips when processing your 5.5 bootloader ?
Hmm, in the boot-prompt I just type the file-name of the linux kernel
instead of the vxWorks kernel. Not special issues. I guess I was lucky,
because I really don't know much about these issues!

Esben

>   need to revise the entry points? using the 0x200000 original addresss o=
f linux kernel ?=20
>   The serial port print what info after "starting at 0x200000 ...." ?=20
>  =20
>   thanks a lot!
>  =20
>=20
> -----=D4=AD=CA=BC=D3=CA=BC=FE-----
> =B7=A2=BC=FE=C8=CB: Esben Nielsen [mailto:simlo@phys.au.dk]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2005=C4=EA7=D4=C228=C8=D5 15:47
> =CA=D5=BC=FE=C8=CB: Frank
> =B3=AD=CB=CD: FCG WANG Baohua; linuxppc-embedded@ozlabs.org
> =D6=F7=CC=E2: Re: How to load a linux kernel under vxworks bootloader
> (PPC860board)
>=20
>=20
> On Wed, 27 Jul 2005, Frank wrote:
>=20
> >=20
> >=20
> > --- FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn> wrote:
> >=20
> > > Dear All:
> > >   I want to boot a linux 2.4.25 kernel under vxworks
> > > bootloader. When I using flat mode(0x200000 -->  0x10000)
> > > kernel  uncompressed ELF format ( vmlinux ),
> > >  and download it using TFTP of vxworks, it print the "starting
> > > at 0x1000 ...." and  freeze.  No input or output on serial
> > > port.
> > >  The version of vxworks is 5.3.1.=20
> > >  can you give me some detail advice or give me a tool to slove
> > > it? thanks !
>=20
> I have done it on a MPC5200 with a vxWorks 5.5 bootsector with ethernet
> support: I just boot over FTP.  Give it the Linux kernel in elf-format,=
=20
> the bootsector doesn't care, _what_ the code actually is, it just loads
> and run it.=20
>=20
> For vxWorks <=3D 5.4 I believe coff is used instead of elf - at least on
> some architectures. Then you have a problem, because the kernel isn't
> compiled to coff :-(
>=20
> Esben
>=20
>=20
> >=20
> > Do what I did:
> > Replace the vxWorks rom with you u-boot and you can boot Linux
> > or vxWorks with the same bootloader.
> >=20
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam protection around=20
> > http://mail.yahoo.com=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
>=20
>=20
