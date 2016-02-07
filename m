Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EFDE1A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:39:13 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] powerpc/ps3: gelic_udbg: drop local versions of network
 data structs
Date: Sun,  7 Feb 2016 17:38:46 +0000
Message-Id: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several network-related data structures are defined in gelic_udbg.
These could be easily dropped and the standard ones defined in network
headers could be used instead.

The 4 patches that follow replace ethernet, vlan, ip and udp
structures in gelic_udbg.  Note that this has been compile-tested
only.

Luis Henriques (4):
  powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
  powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
  powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
  powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>

 arch/powerpc/platforms/ps3/gelic_udbg.c | 71 +++++++++++----------------------
 1 file changed, 23 insertions(+), 48 deletions(-)
