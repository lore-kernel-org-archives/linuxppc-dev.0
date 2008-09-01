Return-Path: <rajasekaran.k@hcl.in>
Received: from gws03.hcl.in (gws03.mail.hcl.in [203.105.186.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws03.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 03231DDED5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 02:00:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: Compile new kernel for 5200B w/ ELDK
Date: Mon, 1 Sep 2008 21:10:41 +0530
Message-ID: <67480A61D7CE4641B90CDD3C58C7AEC77387F9@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
In-Reply-To: <m2bpz8j5bw.fsf@ohwell.denx.de>
References: <1219770125l.5709l.0l@antares> <m2bpz8j5bw.fsf@ohwell.denx.de>
From: "Rajasekaran Kaliyaperumal,  Chennai" <rajasekaran.k@hcl.in>
To: "Detlev Zundel" <dzu@denx.de>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear Detlev=2E=2E=2E
     Am working with PowerPc 8315rdb=2E=2E=2Eand ma using recend version of
the kernel 2=2E6=2E26=2E=2Ebut I found one problem with RTC m41t11=2E=
=2Ewhile trying
to read or set RTC which is already opened while booting itself,,,its
return the error message as resourse busy  with error no 29=2E=2E can u=
 help
me to solve this issue,,,
 With Regards
 Rajasekaran=2E=2E
 HCLT=2EIndia=2E

-----Original Message-----
From: linuxppc-embedded-bounces+rajasekaran=2Ek=3Dhcl=2Ein@ozlabs=2Eorg
[mailto:linuxppc-embedded-bounces+rajasekaran=2Ek=3Dhcl=2Ein@ozlabs=2Eorg]=
 On
Behalf Of Detlev Zundel
Sent: Monday, September 01, 2008 8:12 PM
To: linuxppc-embedded@ozlabs=2Eorg
Subject: Re: Compile new kernel for 5200B w/ ELDK

Hi Albrecht,

> please excuse a probably really dumb question about compiling a new =20
> kernel for a Freescale 5200B using the ELDK 4=2E2=2E=2E=2E
>
> I am playing with a Lite5200B eval board=2E  The software coming from =20
> Freescale, including an older kernel (2=2E6=2E16=2E11-rt18), works fine=
=2E
>
> I installed ELDK 4=2E2 on a FC box, and first compiled u-boot 1=2E3=2E4=
=2E  =20
> Wrote it to flash, and it works nicely afaict=2E
>
> Then I compiled the 2=2E6=2E24=2E2 kernel coming with the ELDK, using the=
 =20
> commands "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200_defconfig
; =20
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage"=2E  The kernel=
 loads, =20
> decompresses, but then there is no output any more after
"Uncompressing =20
> Kernel Image =2E=2E=2E OK"=2E  The u-boot environment contains (quoted=
 from =20
> printenv) "bootargs=3Dconsole=3DttyPSC0,115200 root=3D/dev/mtdblock0 rw =
=20
> rootfstype=3Djffs2 verbose" (and, again, the Freescale kernel is not =20
> silent)=2E
>
> I found a message which stated that I should include
>
> <snip>
>          chosen {
>                  linux,stdout-path =3D "/soc5200@f0000000/serial@2000";
> 	};
> </snip>
>
> in the file arch/powerpc/boot/dts/lite5200=2Edts=2E  Recompiled, but =20
> without success=2E  I believe it's a minor tweak I need to add, but I =20
> don't have a clue what=2E  Unfortunately neither the wiki nor Google
gave =20
> answers=2E  Can anyone enlighten me??

Use a recent kernel version=2E  2=2E6=2E26 should work out of the box=
 without
too much hassle=2E  Some of the older versions had problems effectively
stalling Linux very early without any output on the console=2E

Do not put any more effort in such an old kernel=2E

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr=2E5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx=2Ede

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs=2Eorg
https://ozlabs=2Eorg/mailman/listinfo/linuxppc-embedded

DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
