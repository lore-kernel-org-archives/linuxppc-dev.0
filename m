Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id EB5C3DE016
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 00:10:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] powerpc: Xilinx: add dts file for ML507 board
Date: Wed, 2 Jul 2008 08:10:03 -0600
In-Reply-To: <20080701205301.1acdf087@zod.rchland.ibm.com>
References: <20080701230301.E23A7198050@mail68-va3.bigfish.com>
	<20080701205301.1acdf087@zod.rchland.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-ID: <20080702141015.61D5D398051@mail70-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Stephen Neuendorffer <stephenn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

It's looking like I need to update this anyway for some changes to our
reference system I just learned about.

I'll talk with Stephen about dts-v1 as he does most of the dts
generation work.

Thanks,
John

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com] =

Sent: Tuesday, July 01, 2008 6:53 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca; John Linn
Subject: Re: [PATCH] powerpc: Xilinx: add dts file for ML507 board

On Tue, 1 Jul 2008 16:02:54 -0700
John Linn <john.linn@xilinx.com> wrote:

> This new file adds support for the ML507 board which
> has a Virtex 5 FXT FPGA with a 440.

I haven't looked this over thoroughly yet, but an immediate question
comes to mind.  Any way this can get converted to dts-v1 before it's
pulled in?  All of the in-tree DTS files should be dts-v1 now, so I'd
like to have new ones go in as that.

(Also CC'ing the proper list)

josh


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
