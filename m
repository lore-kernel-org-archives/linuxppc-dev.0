Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 9763AB7D0D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 00:43:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/2] [V5] Add non-Virtex5 support for LL TEMAC driver
Date: Tue, 13 Apr 2010 08:43:09 -0600
In-Reply-To: <20100413.013403.184052247.davem@davemloft.net>
References: <1270746482-29914-1-git-send-email-john.linn@xilinx.com><960dddba-8a63-4480-8245-f06fad59ab36@SG2EHSMHS005.ehs.local><x2sfa686aa41004091110l87cd2234rc68906080fc4fe03@mail.gmail.com>
	<20100413.013403.184052247.davem@davemloft.net>
From: John Linn <John.Linn@xilinx.com>
To: "David Miller" <davem@davemloft.net>, <grant.likely@secretlab.ca>
Message-ID: <9d7342a6-0819-4cf1-941c-d397ca02d5a0@VA3EHSMHS036.ehs.local>
Cc: eric.dumazet@gmail.com, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	jtyner@cs.ucr.edu, michal.simek@petalogix.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, April 13, 2010 2:34 AM
> To: grant.likely@secretlab.ca
> Cc: John Linn; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
jwboyer@linux.vnet.ibm.com;
> eric.dumazet@gmail.com; john.williams@petalogix.com;
michal.simek@petalogix.com; jtyner@cs.ucr.edu
> Subject: Re: [PATCH 2/2] [V5] Add non-Virtex5 support for LL TEMAC
driver
> =

> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Fri, 9 Apr 2010 12:10:21 -0
> =

> > On Thu, Apr 8, 2010 at 11:08 AM, John Linn <john.linn@xilinx.com>
wrote:
> >> This patch adds support for using the LL TEMAC Ethernet driver on
> >> non-Virtex 5 platforms by adding support for accessing the Soft DMA
> >> registers as if they were memory mapped instead of solely through
the
> >> DCR's (available on the Virtex 5).
> >>
> >> The patch also updates the driver so that it runs on the
MicroBlaze.
> >> The changes were tested on the PowerPC 440, PowerPC 405, and the
> >> MicroBlaze platforms.
> >>
> >> Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
> >> Signed-off-by: John Linn <john.linn@xilinx.com>
> >
> > Picked up and build tested both patches on 405, 440, 60x and ppc64.
> > No build problems found either built-in or as a module.
> >
> > for both:
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> =

> Ok, both applied to net-next-2.6, thanks everyone for sorting this
> out.

Great! Thanks David, appreciate the help.

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
