Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id A5C2FB6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 02:28:15 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH v11 0/5] flexcan/powerpc: Add support for powerpc flexcan
	(freescale p1010)
Date: Wed, 10 Aug 2011 11:27:45 -0500
Message-Id: <1312993670-23999-1-git-send-email-holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	PPC list <linuxppc-dev@lists.ozlabs.org>, Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With all the patches applied, my p1010rdb works for communicating between
its two can ports and also can communicate with an external PSOC.  I have
done no testing beyond compile testing on an arm system as I have no
access to an arm based system.

For the first three patches in the series, I believe they are all ready
for forwarding to David S. Miller for the netdev tree.  I think patch
4 is ready for submission to the PPC85xx maintainer.  Patch 5 changed
from the previous post by adding a second compatible string for the
fsl,flexcan-p1010 and bringing back the Documentation file in a more
correct form.

Thanks,
Robin Holt
