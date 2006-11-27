Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id A603067C02
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:16:56 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: MPC52xx support rework for 2.6.20
Date: Mon, 27 Nov 2006 14:16:21 -0700
Message-Id: <1164662190802-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rework mpc52xx support in arch/powerpc and add support for lite5200 eval
boards.  This patchset only covers the board support code.  Device
drivers will be sent in a seperate patchset as they need to cc: other
mailing lists

The whole set of pending mpc52xx patches can also be pulled from:
git://git.secretlab.ca/srv/git-trees/public/git/linux-2.6.git#lite5200-merge
