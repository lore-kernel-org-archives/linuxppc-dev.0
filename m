Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 7CF04DDE21
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 22:52:24 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Sat, 6 Sep 2008 14:40:41 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<20080905160017.GA22310@ld0162-tx32.am.freescale.net>
	<20080905201703.0586e131@lappy.seanm.ca>
In-Reply-To: <20080905201703.0586e131@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809061440.41629.matthias.fuchs@esd-electronics.com>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have chosen "hwmon" because those drivers are placed in the kernel's
drivers/hwmon subdirectory. "temp" sounds to much like "temporary" for
me :-)

We can name it "sensor" - inspired by the lm-sensors projects that 
takes care of such sensors. Because these type of devices are not always
used to monitor the whatever hardware  ... sensor could even be better.

So my favorites are sensor@ or hwmon@.

Sean, I can take your "adi" instead of "analog" for this special sensor.

Matthias

On Saturday 06 September 2008 02:17:03 Sean MacLennan wrote:
> On Fri, 5 Sep 2008 11:00:18 -0500
>
> "Scott Wood" <scottwood@freescale.com> wrote:
> > On Fri, Sep 05, 2008 at 12:19:43PM +0200, Stefan Roese wrote:
> > > > +
> > > > +				hwmon@48 {
> > >
> > > Not sure if we shouldn't use
> > >
> > >                                 ad7414@48 {
> > >
> > > here. This is the way it is already done in warp.dts.
> >
> > We shouldn't.  Node names are supposed to be generic:
> > http://playground.sun.com/1275/practice/gnames/gnamv14a.html
>
> Damn. Where were you a year ago when I first introduced this? ;)
>
> And if it is really supposed to be generic, would temp@48 be a
> better name since this is basically a generic temperature chip?
>
> Now that the i2c driver is a full of platform driver, I think I
> can change the name with no repercussions. So I can live with whatever
> decision is made. Can't do anything about the systems that are out in
> the field though....
>
> Cheers,
>    Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
