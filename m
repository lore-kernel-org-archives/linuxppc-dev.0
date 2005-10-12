Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 0CFBF684C7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 14:20:36 +1000 (EST)
In-Reply-To: 
Date: Tue, 11 Oct 2005 21:20:30 -0700
Message-Id: <200510112120.0zjEUfdtXtv77Emb@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/4] updated 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is an updated series of patches that add basic support for AMCC's
PowerPC 440SPe SoC.  With these patches, the kernel will boot and run
on the "Yucca" 440SPe eval board, with ethernet, serial and PCI
Express in root port mode working (tested with an InfiniBand HCA,
naturally ;).

Since my last posting, I've fixed a few bugs (UIC3 interrupt handling
being the most notable fix) and implemented basic PCI Express support.
I left out the changes required for the old ibm_emac ethernet driver,
since I'm assuming Eugene's new driver will be merged, and his tree
already has 440SPe support.

I now have all the features I need for the project I'm working on, so
I don't expect to be adding much to my port.  I will do whatever
cleanup, bugfixing and integration is required to get this merged
upstream.  It looks like 2.6.15 will be opening up soon, so please let
me know if there's anything I can do to make merging easier.

I also have a git tree based on Eugene Surovegin's git tree at

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/ppc440spe.git

that contains all of these patches, in case that makes it easier to
merge this stuff.

Thanks,
  Roland
