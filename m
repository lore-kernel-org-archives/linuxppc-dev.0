Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 104BEB7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 09:38:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] powerpc/5200: Update defconfigs
Date: Thu, 3 Jun 2010 16:22:54 -0700
In-Reply-To: <AANLkTilzGOkvjghvMh3E0kqIWzyZEdG2iF85Dt_d-Rbk@mail.gmail.com>
References: <20100603211755.7822.66.stgit@angua>
	<AANLkTilzGOkvjghvMh3E0kqIWzyZEdG2iF85Dt_d-Rbk@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <b9420114-c787-43c2-9401-1e86dd2a5ede@VA3EHSMHS027.ehs.local>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems to me like what's confused in the defconfigs is two concepts:
1) The requirements of a platform (what options must be set and must not
be set)
2) The guarantee that a particular config was known to work at some
point in time.

The first could allow you to drop 99% of the options (I think that this
mainly what Linus objects to)
The second is better handled with testing anyway (assuming that all of
the unmentioned options are, in fact, unset)

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Grant
Likely
> Sent: Thursday, June 03, 2010 4:13 PM
> To: grant.likely@secretlab.ca
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/5200: Update defconfigs
> =

> On Thu, Jun 3, 2010 at 3:17 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> =

> ... and my timing is fantastic in light of the defconfig discussion
> going on on the LKML.  :-)
> =

>  http://lkml.org/lkml/2010/6/2/472
> =

> g.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
