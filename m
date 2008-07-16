Return-Path: <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 16:29:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Support for DS75 thermal sensor
Message-ID: <20080716162942.6fcb526d@hyperion.delvare>
In-Reply-To: <9e4733910807160718y580292abi5f44a05f466fd358@mail.gmail.com>
References: <487331DC.2020601@grandegger.com> <4873670C.6080204@grandegger.com>
	<20080708152935.7457bc90@hyperion.delvare>
	<487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
	<487DBB92.1070100@grandegger.com>
	<20080716113311.384d211e@hyperion.delvare>
	<487DC457.6000103@grandegger.com>
	<20080716121059.2dbbfebe@hyperion.delvare>
	<20080716140807.GB24045@secretlab.ca>
	<9e4733910807160718y580292abi5f44a05f466fd358@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Alan Clucas <alanc@pipstechnology.co.uk>,
	Detlev Zundel <dzu@denx.de>, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jul 2008 10:18:26 -0400, Jon Smirl wrote:
> On 7/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Wed, Jul 16, 2008 at 12:10:59PM +0200, Jean Delvare wrote:
> >  > On Wed, 16 Jul 2008 11:50:15 +0200, Wolfgang Grandegger wrote:
> >  > > Jean Delvare wrote:
> >  > >
> >
> > > > Yep, as probing might not be acceptable in some cases, I makes sense to
> >  > > add a property to suppress probing:
> >  >
> >  > It'd rather make no-probing the default if possible. My understanding
> >  > is that all systems using i2c-mpc should have proper platform data.
> >
> >
> > Total ACK.  From my perspective, probing should be off by default because the
> >  typical use case in powerpc land is to trust data in the device tree.  Add the
> >  property to turn on probing, not to turn it off.  Also, you'll need to
> >  document the semantics of such a property.  ie. what exactly does it
> >  mean when the probing property is present and the spi bus node has child
> >  nodes?
> 
> I've found this thread now. Why can't we totally remove probing from
> i2c-mpc? These are embedded systems, not open boxes like a PC. If a
> i2c client hasn't been converted to the new model yet, convert it
> before deploying with the new i2c-mpc driver.  It's not very hard to
> convert the client drivers.

I tend to agree. And the number of unconverted drivers is getting very
low these days. Only 2 RTC drivers are left, and by the end of the day,
almost all hwmon drivers will be converted as well.

-- 
Jean Delvare
