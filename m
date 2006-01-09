Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EBF6689ED
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 19:33:10 +1100 (EST)
In-Reply-To: 
Date: Mon, 9 Jan 2006 01:32:59 -0700
Message-Id: <11367955793438-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: glikely@gmail.com, mporter@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org, gnathita@gmail.com, dhlii@dlasys.net
From: grant.likely@secretlab.ca
Subject: [PATCH 00/10] Xilinx Virtex-* updates
Reply-To: grant.likely@secretlab.ca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here's a repost of my Xilinx ML300 and ML403 patches with a few
cleanups, a bit of patch reordering, and rebased to 2.6.15.

Changes:
 - Remove xparameters.h as a dependancy to most of the kernel tree
 - Rework Virtex-II Pro support to be generic for Virtex-4 also
 - Move serial drivers from the OCP bus to the platform bus
 - Modify ML300 to use platform bus
 - Add support for ML403
 - Add ML300 & ML403 defconfigs

I've tested on an ML403
Can someone test on an ML300?  (I no longer have one)

Cheers,
g.
