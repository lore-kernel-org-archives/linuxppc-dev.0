Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76372DDF9F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 03:31:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
Date: Mon, 12 May 2008 10:31:28 -0700
In-reply-to: <fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080512173130.0D747181804D@mail89-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Not easily.  As we discussed before, there is nowhere that really
specifies this information.  In some cases I've modified the device tree
generator to understand what is backward compatible, as with ns16550,
but for other cores it makes more sense to me to put this compatibility
information with the driver if it has to be anywhere.

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Monday, May 12, 2008 7:25 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507
dvi core.
>=20
> On Mon, May 5, 2008 at 11:59 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> > Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
> >  ---
> >   drivers/video/xilinxfb.c |    1 +
> >   1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >  diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> >  index 848752e..a82c530 100644
> >  --- a/drivers/video/xilinxfb.c
> >  +++ b/drivers/video/xilinxfb.c
> >  @@ -396,6 +396,7 @@ static int __devexit xilinxfb_of_remove(struct
of_device *op)
> >   /* Match table for of_platform binding */
> >   static struct of_device_id xilinxfb_of_match[] __devinitdata =3D {
> >         { .compatible =3D "xlnx,plb-tft-cntlr-ref-1.00.a", },
> >  +       { .compatible =3D "xlnx,plb-dvi-cntlr-ref-1.00.c", },
>=20
> Can you get the dvi core to claim compatibility with the tft core
> (assuming it is register level backwards compatible)?
>=20
> Cheers,
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
