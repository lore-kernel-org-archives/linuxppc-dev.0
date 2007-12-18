Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C63DEDDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Dec 2007 20:14:54 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J4YXK-0002yn-5x
	for linuxppc-embedded@ozlabs.org; Tue, 18 Dec 2007 01:14:50 -0800
Message-ID: <14387041.post@talk.nabble.com>
Date: Tue, 18 Dec 2007 01:14:50 -0800 (PST)
From: TomX <gbe.tao.xue@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: How about the I2S audio driver for arch/powerpc within MPC5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi, all:

I am now using the sound/ppc/mpc52xx_aic26.c from snapshot of denx. And with
this, need use the arch/ppc, not the arch/powerpc. Is somebody have finished
change this files to arch/poweprc. I have try, but it seems a lot work
needed and must familar with arch/powerpc.

Many thanks,
Best Regards,
Tao
-- 
View this message in context: http://www.nabble.com/How-about-the-I2S-audio-driver-for-arch-powerpc-within-MPC5200B-tp14387041p14387041.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
