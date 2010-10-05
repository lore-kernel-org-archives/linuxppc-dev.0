Return-Path: <anirban.chakraborty@qlogic.com>
Received: from avexcashub1.qlogic.com (avexcashub1.qlogic.com [198.70.193.61])
	by ozlabs.org (Postfix) with ESMTP id 8AB7AB70DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 04:24:30 +1100 (EST)
From: Anirban Chakraborty <anirban.chakraborty@qlogic.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 5 Oct 2010 10:18:19 -0700
Subject: MSI-X vector allocation failure in upstream kernel
Message-ID: <9101728E-3FFC-457E-AF5B-87B2037FEC32@qlogic.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Ameen Rahman <ameen.rahman@qlogic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I am trying to test qlcnic driver (for 10Gb QLogic network adapter) on a Po=
wer 6 system=20
(IBM P 520, System type 8203) with upstream kernel and I do see that the ke=
rnel is=20
not able to allocate any MSI-X vectors. The driver requests for 4 vectors i=
n pci_enable_msix,
which returns 2. The driver again attempts, this time for 2 vectors but the=
 kernel can't allocate=20
and it returns a value of 0xfffffffd. I upgraded the system FW to 01EL350 (=
from 01EL340)
 just to make sure if MSI-X is enabled in the system. Is there anything tha=
t I am missing?=20

Any pointers will be highly appreciated.


thanks,
Anirban Chakraborty=
