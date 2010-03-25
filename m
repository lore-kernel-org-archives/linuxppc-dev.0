Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Mar 2010 17:22:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
Message-ID: <20100325212234.GA26649@yookeroo>
References: <ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 10:59:01AM -0600, Grant Likely wrote:
> On Thu, Mar 25, 2010 at 10:36 AM, Timur Tabi <timur@freescale.com> wrote:
> > Grant Likely wrote:
> >> On Thu, Mar 25, 2010 at 9:29 AM, Mitch Bradley <wmb@firmworks.com> wrote:
> >>> It seems to me that there are plausible use cases for both direct-inclusion
> >>> and indirection.  I don't see any real problems with either, so I would vote
> >>> for specifying both alternatives.
> >>
> >> Ugh.  Then this one driver would need to implement both binding for
> >> little, if any, actual benefit.
> >
> > Although I agree that I don't like supporting both bindings, we could encapsulate the locating of the firmware node in a function.  The function will first look for a child firmware node, and if it doesn't find it, look for a fsl,firmware property.  It will return a pointer to the firmware node regardless.
> >
> >> I'm sure we can come to an agreement
> >> on one method if the firmware absolutely has to be in the tree.
> >
> > If we have to pick one, then I think the only viable choice is have a separate firmware node and a phandle pointer to it.  Otherwise, I just don't see how we can handle multiple devices needing the same firmware.
> 
> Wait for David to weigh in on this one before making a decision.  He
> knows the dtb format best.

I'll do that when I can.  Right now I'm in the middle of intense
bringup work so I won't have time for this for a while.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
