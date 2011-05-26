Return-Path: <B32167@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4907DB6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 17:11:09 +1000 (EST)
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Date: Thu, 26 May 2011 07:11:02 +0000
Message-ID: <470DB7CE2CD0944E9436E7ADEFC02FE31645D1@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE313B1C2@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110310085414.GA4460@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE313B36C@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110525165620.eeaa11ff.akpm@linux-foundation.org>
In-Reply-To: <20110525165620.eeaa11ff.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew Morton,

I have added the support for pt7c4338 in Dallas driver rtc-ds1307.c as sugg=
ested by Wolfram Sang
And send the patch "Add support for pt7c4338 (rtc device) in rtc-ds1307 dri=
ver" for the same which will supersede the previous patch.

Please let me know if anything else is required.

Thanks
Priyanka


> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]
> Sent: Thursday, May 26, 2011 5:26 AM
> To: Jain Priyanka-B32167
> Cc: Wolfram Sang; rtc-linux@googlegroups.com; linuxppc-
> dev@lists.ozlabs.org; a.zummo@towertech.it; p_gortmaker@yahoo.com
> Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
>=20
> On Thu, 10 Mar 2011 11:06:27 +0000
> Jain Priyanka-B32167 <B32167@freescale.com> wrote:
>=20
> > Hi Wolfram,
> >
> >
> > > -----Original Message-----
> > > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > > Sent: Thursday, March 10, 2011 2:24 PM
> > > To: Jain Priyanka-B32167
> > > Cc: rtc-linux@googlegroups.com; linuxppc-dev@lists.ozlabs.org;
> > > a.zummo@towertech.it; p_gortmaker@yahoo.com;
> > > akpm@linux-foundation.org
> > > Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
> > >
> > > Hi Priyanka,
> > >
> > > > Though register-set looks identical but features were different.
> > >
> > > Can you tell what exactly is different?
> > I will check both the devices data sheets again in detail and will get
> back on this.
> > >
> > > > And also manufacturer is different.
> > >
> > > That does not matter. If you look at ds_type, there are already
> > > different manufacturers. They will be correctly distinguished by
> > > i2c_device_id. The name of the driver itself is, well, just a name.
> > >
> > > > But still it might be possible that we can reuse ds1307.c with
> > > > some modification.
> > >
> > > I agree. The driver already supports some variants. Adding one more
> > > should not hurt. See 97f902b7be4dd6ba03c6aa8d3400783ed687ebd1 for an
> > > example which added ds3231 support.
> > >
> > > > But if I look at the drivers present in drivers/rtc folder. Most
> > > > of them looks similar but still there are different drivers for
> > > > different chips.
> > >
> > > Yes, it probably could be cleaned up if somebody had the
> time/hardware.
> > >
> > > > Please suggest which way is more preferred: modifying existing
> > > > drivers(of different manufacturer) or writing new driver.
> > >
> > > Ususally avoiding code duplication is good, it reduces maintenance
> > > burden. However, if adding the support turns out to make the
> > > original code unreadable or hard to follow, a new driver might be
> > > justified. This is why it is important to understand the differences
> > > of the chip as a first step. (I have the feeling, that modifying is
> > > the way to go here, though).
> > >
> >
> > I will explore possibility of using ds1307 driver for this.
> >
>=20
> Has there been any movement here?
