Return-Path: <torsten.demke@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 29F4C67A5C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jan 2005 19:59:36 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id j0H91PJD013672
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jan 2005 02:01:25 -0700 (MST)
Received: from zwg57exm01.ds.mot.com (zwg57exm01.ea.mot.com [10.170.189.6])
	by il06exr04.mot.com (Motorola/il06exr04) with ESMTP id j0H8wCdV016620
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Jan 2005 02:58:12 -0600
Message-ID: <43395BE65409D911B9FF00110A9BFFDC9F86EB@zwg57exm01.ea.mot.com>
From: Demke Torsten-atd012 <torsten.demke@motorola.com>
To: annamaya <annamaya@yahoo.com>, linuxppc-embedded@ozlabs.org
Date: Mon, 17 Jan 2005 09:59:29 +0100
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: ELDK on a PowerPC host machine?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

we use the ELDK on G4 here in the following way:
a) install ELDK on x86
b) move target directory (the one you would use for NFS) to your G4
c) chroot into that target directory on yout G4
d) manually mount /proc, setup path, ...

Compilation of u-boot and Linux Kernel works fine. 
(tested with 82xx and 8xx).

Regards,
Torsten



> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org]On Behalf Of annamaya
> Sent: Freitag, 14. Januar 2005 16:52
> To: linuxppc-embedded@ozlabs.org
> Subject: ELDK on a PowerPC host machine?
> 
> 
> I noticed that ELDK from denx does not support running
> on a PowerPC host machine like the Power G4 or G5.
> When I tried rebuilding it on a Power G4 with
> YellowDog installed on it, it complained that the
> PowerPC host machine is not supported. Why is this
> host architecture not supported? I also found out that
> MontaVista does not support the PowerPC host
> architecture anymore which they did a while ago. What
> seems to be the real reason for not supporting this?
> Thanks for the reply.
> 
> 
> 	
> 		
> __________________________________ 
> Do you Yahoo!? 
> Yahoo! Mail - You care about security. So do we. 
> http://promotions.yahoo.com/new_mail
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
