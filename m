Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19C23688DC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Dec 2005 05:32:44 +1100 (EST)
Message-ID: <43A459C4.9050506@digis.net>
Date: Sat, 17 Dec 2005 11:32:36 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Michael Boutte <maboutte@pacbell.net>
References: <43A3C9B2.6040401@pacbell.net>
In-Reply-To: <43A3C9B2.6040401@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Building a Root Filesystem
Reply-To: Frank Bennett <bennett78@digis.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael Boutte wrote:

> Hi,
> I seem to be stuck at one point in my first embedded Linux project. I 
> built a custom MPC875 board and have figured out how to get U-Boot to 
> compile and run. Then I learned to compile an initial Linux 2.4.25 
> using the ELDK with a basic root filesystem via the "SELF" included in 
> the ELDK (thank you WD and others). Now I want to build a new root 
> filesystem with the modules included. So then I have used the "make 
> modules" and "make ... modules_install" commands plus used the 
> procedure in the DULG section 9.6 to unpack the ramdisk image and 
> mount it in the /mnt/tmp/ directory.
> That is point where I do not know what to do next. It would seem that 
> I need to merge the modules and other items I may want to add (for 
> example appWeb) with the simple root filesystem and re-compress it for 
> use just like the original ramdisk image. I just do not seem to find 
> any information on this process either in the DULG or anywhere else on 
> the web.
> Any help would be greatly appreciated.

I'm also using Linux 2.4.25 using the ELDK and I would recommend
getting a NFS root file system going first discussed in the following
paper, although written for a MPC5200 is an excellent guideline:

    http://emsys.denayer.wenk.be/emcam/Linux_on_MPC5200_(UK).pdf

Worry about a compressed system later. There is also a script for 
building a
small root file system (mkrootfsdenx) from a working reference one and
MTD is the way to go to manage your flash for F/W updates and NVdata store.

happy ELDKing,
Frank Bennett

>
> Mike Boutte
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
