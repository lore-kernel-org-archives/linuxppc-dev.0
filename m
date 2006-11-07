Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id E4B2E67CD0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:34:43 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, nd@bplan-gmbh.de
Subject: [RFC] Lite5200(b) arch/powerpc patchset
Date: Mon,  6 Nov 2006 17:34:20 -0700
Message-Id: <11628596653052-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch set adding support for the Lite5200 eval board in
arch/powerpc.  There are definately things missing/broken in here,
but I can boot to promplt with this patchset.  Plus, I'm fishing for
feedback.  :)

These patches depend on Nicolas' mpc52xx-pic patches
