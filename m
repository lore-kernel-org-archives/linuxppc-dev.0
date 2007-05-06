Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C48C9DDE43
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd5Pr027551
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:06 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: macio modalias & mpc52xx related patches for 2.6.22
Date: Sun,  6 May 2007 17:38:44 +0200
Message-Id: <11784659324066-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,

Here's the patch I'd like to see merged for 2.6.22

The first one fixs the remaining autoload problems that appeared with
the uevent stuff. It has been tested by me, Johannes & benh.

The second & third are just a clean up to avoid discrepency in the
modalias generation (the same string was generated differently at 
several place). They work fine on my G5.

The rest of the series are patch I received on the -embedded list,
they've been reviewed/tested by at least either Grant or me.


	Sylvain
