Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Tue, 9 Dec 2008 06:24:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081209062401.502f2c48@zod.rchland.ibm.com>
In-Reply-To: <200812090710.27781.sr@denx.de>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
	<20081208193446.37e27e26@lappy.seanm.ca>
	<200812090710.27781.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 9 Dec 2008 07:10:27 +0100
Stefan Roese <sr@denx.de> wrote:

> On Tuesday 09 December 2008, Sean MacLennan wrote:
> > On Thu, 4 Dec 2008 09:01:07 -0500
> >
> > "Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:
> > > In addition to an example DTS patch (probably to warp itself), could
> > > you briefly write up a binding and put it in
> > > Documentation/powerpc/dts-bindings/amcc (or similar)?  Also please CC
> > > the devicetree-discuss list on that part.
> >
> > Here is a start at the doc. I have sent it as a patch, but could just
> > as easily send raw text.
> >
> > The example comes from the warp dts, just with less partitions, so I
> > have not included a warp dts patch here.
> >
> > Cheers,
> >    Sean
> >
> > diff --git a/Documentation/powerpc/dts-bindings/amcc/ndfc.txt
> > b/Documentation/powerpc/dts-bindings/amcc/ndfc.txt new file mode 100644
> > index 0000000..668f4a9
> > --- /dev/null
> > +++ b/Documentation/powerpc/dts-bindings/amcc/ndfc.txt
> > @@ -0,0 +1,31 @@
> > +AMCC NDFC (NanD Flash Controller)
> > +
> > +Required properties:
> > +- compatible : "amcc,ndfc".
> 
> The 4xx NAND controller was first implemented on the 440EP, IIRC. So I'm 
> pretty sure that this controller is an IBM core and not am AMCC core. So this 
> should be "ibm,ndfc".

That is true.  It's an IBM blue logic core.
 
> And with this change it makes no sense to put this file "ndfc.txt" into the 
> amcc directory.
> 
> Josh, where should this go then?

I declare it to be: dts-bindings/4xx/

mostly because I don't want the bindings scattered across two
directories simply because of the timeframe they showed up in the
marketplace.

If there are better ideas, I'm all ears.

josh
