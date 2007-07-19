Return-Path: <kim.phillips@freescale.com>
Date: Thu, 19 Jul 2007 16:40:36 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
Message-Id: <20070719164036.f3d4c86d.kim.phillips@freescale.com>
In-Reply-To: <fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
References: <20070719183415.7458.42622.stgit@trillian>
	<20070719183734.7458.83695.stgit@trillian>
	<469FB47D.4030009@freescale.com>
	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2007 13:43:17 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 7/19/07, Scott Wood <scottwood@freescale.com> wrote:
> > Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > To boot from a cuImage requires the device tree to have a
> > > linux,stdout-path property in the chosen node.  This patch adds it
> > > to the .dts files.
> >
> > This will break many current u-boots, as they blindly add a /chosen node
> > regardless of whether one already exists.
> 
> That really should be fixed then.  In the meantime; I'll resubmit the
> patch to add the chosen node; but with it commented out.
> 

the old FLAT_TREE u-boot fdt fixup code renames any existing chosen
node out of the way, and adds its fixed up version as /chosen.

The LIBFDT implementation replaces any existing /chosen with its fixed
up version.

So it all works out.  Adding chosen/linux,stdout-path properties to the
kernel dtses is fine.

btw, why are these changes being limited to the ITX and GP?

Kim
