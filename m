Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 07DD6DE0CA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:17:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART initialization
Date: Mon, 17 Mar 2008 13:17:32 -0700
In-Reply-To: <fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
References: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com><fa686aa40803171247j709bc554pe709628c46205600@mail.gmail.com><20080317195756.4F7411BE807D@mail119-dub.bigfish.com>
	<fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, "John Linn" <linnj@xilinx.com>
Message-Id: <20080317201731.CED20181005E@mail146-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant,

If you have working platform code using libfdt, can you publish it?

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Grant
Likely
> Sent: Monday, March 17, 2008 1:08 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART
initialization
>=20
> On Mon, Mar 17, 2008 at 1:57 PM, John Linn <John.Linn@xilinx.com>
wrote:
> > That makes sense.  Since I'm not using a boot loader I didn't
realize
> >  that.
> >
> >  I'm not sure how hard it will be to get the data from the device
tree at
> >  that time.
>=20
> You should be good.  It is now possible to read data from the device
> tree at platform_init() time.
>=20
> Cheers,
> g.
>=20
> >  What about checking to see if it's setup assuming that's possible
by
> >  looking at registers, and then not messing with it if it's already
> >  setup, otherwise do what my patch does.
>=20
> Ugh.  The old arch/ppc code used to do this and it was kind of ugly
> and fragile.  I'd rather avoid doing it again.
>=20
> Cheers,
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
