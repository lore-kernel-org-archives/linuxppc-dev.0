Return-Path: <roffermanns@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id 6065AB7BE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 01:30:55 +1100 (EST)
Received: from donald.sysgo.com (unknown [172.22.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id C1DAF7464E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 15:21:35 +0100 (CET)
Received: from rof.sysgo.com (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id 2A49634479F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 15:23:17 +0100 (CET)
Message-ID: <4B191B54.6030804@sysgo.com>
Date: Fri, 04 Dec 2009 15:23:16 +0100
From: Rolf Offermanns <roffermanns@sysgo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: TQM5200 + SM501 FB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

does anyone has a working SM501 framebuffer on the STK5200 board? The 
board itself works fine on the 2.6.32 kernel.

I got a patch from TQ which used to work around 2.6.24 but it seems with 
the unification of the "simple mpc5200" boards the sm501 support got lost.

I toyed around with the patch a bit and I got the driver to probe and 
initialize the chip, but I don't get an output on the crt port and an 
open() on /dev/fb0 or /dev/fb1 fails with "no device".

Any hints are welcome.

Thanks,
Rolf.
