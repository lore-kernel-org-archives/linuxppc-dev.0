Return-Path: <dgibson@ozlabs.org>
Date: Sat, 16 Aug 2008 15:06:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH V2] DTC: Remove support for the legacy DTS source file
	format.
Message-ID: <20080816050630.GA12072@yookeroo.seuss>
References: <E1KTlq7-0005Gh-Co@jdl.com> <20080815002936.GA9877@yookeroo.seuss>
	<ed82fe3e0808150817k66d6c70fp17774fbd726ea2b2@mail.gmail.com>
	<E1KU1Td-0006ub-8O@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1KU1Td-0006ub-8O@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 15, 2008 at 10:44:33AM -0500, Jon Loeliger wrote:
> > On Thu, Aug 14, 2008 at 7:29 PM, David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> > > On Thu, Aug 14, 2008 at 06:02:43PM -0500, Jon Loeliger wrote:
> > >> Now that all in-kernel-tree DTS files are properly /dts-v1/,
> > >> remove direct support for the older, un-numbered DTS
> > >> source file format.
> > >
> > > Um.. why?  I just don't see a compelling reason to remove this
> > > backwards compatibility.  It costs us very little to keep it around
> > > indefinitely.
> 
> Because we are going to get rid of the cruft, simplify things,
> and move forward.  Really.  This was the plan from the onset.

Uh.. removing compatibility for the old format was never part of *my*
plan for the change.  Discourage any further use of the v0 format,
yes, remove support for, no.

I just don't see a benefit to this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
