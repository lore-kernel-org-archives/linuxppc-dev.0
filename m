Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 2903067BF5
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:21:15 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/2] arch/powerpc support for MPC52xx serial driver
Date: Mon, 27 Nov 2006 14:21:00 -0700
Message-Id: <1164662462514-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the serial driver changes required for mpc52xx support in
arch/powerpc.  First patch takes the opportunity to do a whitespace
cleanup seeing as the patch is undergoing heavy change anyway.

Cheers,
g.
