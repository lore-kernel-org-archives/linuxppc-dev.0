Date: Thu, 4 Apr 2002 16:32:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020404063228.GQ21034@zax>
References: <scac60f5.069@au.thalesgroup.com> <3CABEFCE.8050006@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CABEFCE.8050006@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 04, 2002 at 01:16:46AM -0500, Dan Malek wrote:
>
> Jeremy Rosen wrote:
>
>
> >can't we use the __GFP_DMA flag to specify that the area must have
> >algnment enforced ?
>
> Maybe, but that isn't its intended use.
>
> >or did I misunderstand the use of this flag ?
>
> This flag is used on architectures that have memory only accessible
> from the processor, not from a DMA device, to ensure a DMA device
> gets a memory bank that it can access.

More specifically it's used on x86 for old ISA devices.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
