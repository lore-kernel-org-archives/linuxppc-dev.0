Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E79A0DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Oct 2007 14:45:51 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Icw7H-0006B0-5o
	for linuxppc-embedded@ozlabs.org; Tue, 02 Oct 2007 21:45:47 -0700
Message-ID: <13012850.post@talk.nabble.com>
Date: Tue, 2 Oct 2007 21:45:47 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: jffs2 file system on MPC8272ADS
In-Reply-To: <46FBD7FE.6050500@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12873633.post@talk.nabble.com>
	<20070925152301.GC15739@ld0162-tx32.am.freescale.net>
	<12914822.post@talk.nabble.com> <46FBD7FE.6050500@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Scott,

>Most common is making a jffs2 filesystem with the wrong block size.  It 
>could also be an incorrect flash mapping.

 In our case erase block size and flash mapping seems to be correct.

> Was it the physmap driver or the pq2fads driver that found the flash?
>        
>              Flash is cfi compatible.
>>That's not what I meant...  you have two mapping drivers enabled, and 
>>the pq2fads driver might be doing something other that what you 
>>specified to physmap.  I'd just disable it.

I think if flash is cfi compatible then it uses default driver.




_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



-- 
View this message in context: http://www.nabble.com/jffs2-file-system-on-MPC8272ADS-tf4513571.html#a13012850
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
