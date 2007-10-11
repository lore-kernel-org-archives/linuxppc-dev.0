Return-Path: <SRS0=DCot=PF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id A4AD3DDFD4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 22:01:45 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Kilauea DTS
Date: Thu, 11 Oct 2007 14:02:12 +0200
References: <200710081110.16447.sr@denx.de> <200710111049.02253.sr@denx.de>
	<1192103498.5534.101.camel@localhost.localdomain>
In-Reply-To: <1192103498.5534.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710111402.12449.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 October 2007, Josh Boyer wrote:
> On Thu, 2007-10-11 at 10:49 +0200, Stefan Roese wrote:
> > > > +		PowerPC,405EX@0 {
> > > > +			device_type = "cpu";
> > > > +			reg = <0>;
> > > > +			clock-frequency = <0>; /* Filled in by U-Boot */
> > >
> > > Filled in by U-Boot itself?  Or by a cuboot wrapper? (which I can't
> > > find in the patches.)
> >
> > By U-Boot itself. I have a U-Boot patch in the queue to add device tree
> > support for 4xx. Therefor I don't plan adding a cuboot wrapper for
> > Kilauea.
>
> Very cool!

You can take a look at the kilauea-405ex branch of my 4xx custodian repository 
for a latest development snapshort:

http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot/u-boot-ppc4xx.git;a=shortlog;h=kilauea-405ex

> > > > +				interrupt-parent = <&UIC1>;
> > > > +
> > > > +				nor_flash@0,0 {
> > >
> > > You have no ranges property for the ebc parent node.  Is if filled in
> > > by U-Boot?  If so, please add a comment because otherwise I don't see
> > > how this mapping will work.
> >
> > Yes, it's filled in by U-Boot too. I'll add a comment here.
>
> Ok.
>
> > > No chosen node?
> >
> > No. U-Boot will provide all needed information here.
>
> Does it provide it by creating the chosen node?  Or by still using the
> bd_t method?

bd_t? What's that? ;)

Best regards,
Stefan
