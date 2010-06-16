Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] of/address: restrict 'no-ranges' kludge to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1C7A9067-DDE6-47D3-AC78-FDC081354519@kernel.crashing.org>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141018.25879.44413.stgit@angua>
	<1276152275.1962.61.camel@pasglop>
	<1C7A9067-DDE6-47D3-AC78-FDC081354519@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 10:33:54 +1000
Message-ID: <1276648434.2552.165.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-15 at 18:23 +0200, Segher Boessenkool wrote:
> >> Certain Apple machines don't use the ranges property correctly,  
> >> but the
> >> workaround should not be applied on other architectures.  This patch
> >> disables the workaround for non-powerpc architectures.
> >
> > I'm half tempted to add it to the quirk list (which should really be
> > made generic) so I can disable it on more 'modern' powerpc as well.
> 
> Oh please oh please oh please yes do.
> 
> OTOH, it would be even better to just fix up the device tree in the
> early platform code.  Quirks are for broken hardware; software, we
> can fix.

That would work if I could bloody remember which machines need what on
what nodes ... some of those are ancient and I don't have access to all
of them.

Cheers,
Ben.
