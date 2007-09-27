Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FBC3DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 02:19:37 +1000 (EST)
Message-ID: <46FBD7FE.6050500@freescale.com>
Date: Thu, 27 Sep 2007 11:19:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Nethra <nethra_gmit@yahoo.co.in>
Subject: Re: jffs2 file system on MPC8272ADS
References: <12873633.post@talk.nabble.com>	<20070925152301.GC15739@ld0162-tx32.am.freescale.net>
	<12914822.post@talk.nabble.com>
In-Reply-To: <12914822.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nethra wrote:
>>> They are errors.
> 
> which are all the most possible reasons for these errors ?

Most common is making a jffs2 filesystem with the wrong block size.  It 
could also be an incorrect flash mapping.

>>> Was it the physmap driver or the pq2fads driver that found the flash?
>        
>              Flash is cfi compatible.

That's not what I meant...  you have two mapping drivers enabled, and 
the pq2fads driver might be doing something other that what you 
specified to physmap.  I'd just disable it.

>>> Which kernel are you using, and are you using arch/ppc or arch/powerpc?
>>> -Scott
>           
>            KERNEL: linux-2.6.10 and we r using arc/ppc 	

That's pretty old...  If all else fails, you may want to see if never 
kernels still have the problem.

-Scott
