Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 15AAB67B24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 19:49:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4OA5Q6g013116 for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 03:05:26 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4O9n85d024072
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 04:49:09 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467308148A@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'tony'" <hangtoo@163.com>, linuxppc-embedded@ozlabs.org
Subject: RE: delay programming
Date: Wed, 24 May 2006 17:48:58 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

That depends on how accurate you want.  Sleep() functions can't be too accurate 
for Linux schedule characteristic.  To get best accuracy, you can use hardware
timer.  udelay() is a choice which reduces the overall system performance.

Best Regards,
Leo


> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On Behalf
> Of tony
> Sent: Wednesday, May 24, 2006 5:24 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: delay programming
> 
> 
> hi all
> 	I want to delay 1ms in the program,
> 	does usleep(1000) works accurate?
> 	any good idea?
> 
> regards
> tony
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
