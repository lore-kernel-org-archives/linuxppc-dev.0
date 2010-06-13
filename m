Return-Path: <edgar.iglesias@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id 87919B7D9C
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 16:47:59 +1000 (EST)
Received: by wwb28 with SMTP id 28so2652996wwb.15
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 23:47:57 -0700 (PDT)
Date: Sun, 13 Jun 2010 08:47:52 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: microblaze-uclinux@itee.uq.edu.au
Subject: Re: [microblaze-uclinux] Re: Request review of device tree
	documentation
Message-ID: <20100613064752.GA10238@laped.lan>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<20100612221554.GA17876@lixom.net>
	<AANLkTimgvKoCBOkhVeLX-uHtRzFPMWpVtZNipKvekOJv@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimgvKoCBOkhVeLX-uHtRzFPMWpVtZNipKvekOJv@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Mitch Bradley <wmb@firmworks.com>, Olof Johansson <olof@lixom.net>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 12, 2010 at 05:09:36PM -0600, Grant Likely wrote:
> On Sat, Jun 12, 2010 at 4:15 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Sat, Jun 12, 2010 at 12:53:59AM -0600, Grant Likely wrote:
> >
> >> I also changed the property in the cpu nodes from model to compatible
> >> so that the exact CPU version can be specified.  This isn't actually
> >> in any spec anywhere, but I need something to properly identify the
> >> different ARM cores.
> >
> > I don't see why this has to be in the device tree. It's not there on PPC.
> > The exact CPU version is found through the PVR register on PPC, ARM also
> > has cpu version and feature registers for runtime probing.
> 
> I had been told that they runtime registers weren't reliable.  If I'm
> misinformed, then yes the compatible value can be dropped from the cpu
> nodes.

Hi all,

If it's not too painful to keep, I think it will be valuable if one
want's to instantiate HW based/from this same device tree. For example
for emulators.

Cheers
