Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id AF28368385
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:13:49 +1000 (EST)
In-Reply-To: 
Date: Thu, 22 Sep 2005 20:03:34 -0700
Message-Id: <2005922203.zpZEPMsMBP43qjJI@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/4] 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is a series of patches that add basic support for AMCC's PowerPC
440SPe SoC.  With these patches, the kernel will boot and run on the
"Yucca" 440SPe eval board, with ethernet and serial working.

I don't have PCI-X or PCI Express in a mergeable state, but I thought
it would be worth posting these now for review.  Also, it would
probably be good to figure out how we want to merge this upstream once
2.6.14 comes out -- 440SPe requires some minor changes to ethernet PHY
handling, which will have to be coordinated with the ibm_emac rewrite,
and there are also some minor conflicts with the 440GR patches I saw.

Right now I'm working on PCI Express support, and I'll post those
patches once I have something reasonable.

I also have a git tree at

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/ppc440spe.git

that contains all of these patches, in case that makes it easier to
merge this stuff.

Thanks,
  Roland
