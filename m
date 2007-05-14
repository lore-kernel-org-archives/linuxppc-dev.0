Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7BC5EDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:27:12 +1000 (EST)
Date: Mon, 14 May 2007 14:30:12 -0500
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
Message-ID: <20070514193012.GA1693@lixom.net>
References: <200705140946.41993.david-b@pacbell.net>
	<20070514180545.GA1437@lixom.net>
	<200705141137.39961.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705141137.39961.david-b@pacbell.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 11:37:39AM -0700, David Brownell wrote:
> On Monday 14 May 2007, Olof Johansson wrote:
> > On Mon, May 14, 2007 at 09:46:41AM -0700, David Brownell wrote:
> 
> > > Didn't update the pasemi reference board; public info doesn't say
> > > which chip it uses.
> > 
> > ds1338.
> 
> OK.  The relevant updates should be evident from this patch.
> 
> Mr Grep tells me that if those powerpc platforms update along
> with csb337, all current rtc-ds1307 users will be upgraded.
> 
> Then there's a separate issue of removing the old SENSORS_DS1337
> driver.  Simpler IMO for those drivers to have one transition,
> to new-style rtc-ds1307, not two (to old-style, then new-style).

Sounds good.

> > > NOTE:  cc'd the relevant powerpc maintainers lists; patches 1-3
> > > will be archived in the rtc and i2c lists.  I'd like to see these
> > > get tested/fixed so that the rtc-ds1307 driver can switch completely
> > > to use the new-style I2c driver model.
> > 
> > Specific URLs can sometimes be useful, so we don't have to go digging
> > through the archives. But thanks for the heads up, I'll make the
> > corresponding changes to my code and test it out.
> 
> The URLS don't exist until after the email's gotten to the list
> servers ... sort of a chicken/egg issue.

Ah yes, good point.

> > (I'm guessing long-term, we will want to pull the chip info out of the
> > device tree instad of have it in a table in the board code, but that's
> > extra credit at the moment.)
> 
> For some definition of "long term".  ISTR seeing patches from Scott Wood
> doing exactly that ... on the I2C list last November or so.  ;)

Yep, I asked on IRC and got a similar answer. I had forgotten about them.

> Right now my concern is how to migrate the rtc-ds1307 driver.  I'd
> prefer to avoid needing to have a period where the legacy mode must
> co-exist with the new-style driver support, or needing to entangle
> with such tree conversions.

Which is why I said "long term", as in "after this is done". :)


-Olof
