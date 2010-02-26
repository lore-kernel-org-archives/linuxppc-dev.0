Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id CEE89B7D18
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 10:08:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Proposal to move PCI out of arch/powerpc and into drivers/of
Date: Fri, 26 Feb 2010 16:07:59 -0700
From: John Linn <John.Linn@xilinx.com>
To: <linux-kernel@vger.kernel.org>, <devicetree-discuss@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>, <microblaze-uclinux@itee.uq.edu.au>
Message-ID: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
Cc: michal.simek@petalogix.com, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

We are in the process of putting PCI/PCIe into the microblaze
architecture.  =


In order to not duplicate/fork the PCI code in Powerpc, we're proposing
to move the PCI code from arch/powerpc into drivers/of such that it
would be common code for Powerpc and MicroBlaze.

This would be the 1st part of a refactoring that would occur with the
PCI code.

Ben H., would you mind if that happened (move arch/powerpc/kernel/pci*
to drivers/of/*)?

Thanks,
John

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
