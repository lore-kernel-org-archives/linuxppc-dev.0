Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEF7CB6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 09:56:59 +1000 (EST)
Date: Wed, 25 May 2011 16:56:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-Id: <20110525165620.eeaa11ff.akpm@linux-foundation.org>
In-Reply-To: <470DB7CE2CD0944E9436E7ADEFC02FE313B36C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE313B1C2@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110310085414.GA4460@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE313B36C@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 10 Mar 2011 11:06:27 +0000
Jain Priyanka-B32167 <B32167@freescale.com> wrote:

> Hi Wolfram, 
> 
> 
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > Sent: Thursday, March 10, 2011 2:24 PM
> > To: Jain Priyanka-B32167
> > Cc: rtc-linux@googlegroups.com; linuxppc-dev@lists.ozlabs.org;
> > a.zummo@towertech.it; p_gortmaker@yahoo.com; akpm@linux-foundation.org
> > Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
> > 
> > Hi Priyanka,
> > 
> > > Though register-set looks identical but features were different.
> > 
> > Can you tell what exactly is different?
> I will check both the devices data sheets again in detail and will get back on this.
> > 
> > > And also manufacturer is different.
> > 
> > That does not matter. If you look at ds_type, there are already different
> > manufacturers. They will be correctly distinguished by i2c_device_id. The
> > name of the driver itself is, well, just a name.
> > 
> > > But still it might be possible that we can reuse ds1307.c with some
> > > modification.
> > 
> > I agree. The driver already supports some variants. Adding one more
> > should not hurt. See 97f902b7be4dd6ba03c6aa8d3400783ed687ebd1 for an
> > example which added ds3231 support.
> > 
> > > But if I look at the drivers present in drivers/rtc folder. Most of
> > > them looks similar but still there are different drivers for different
> > > chips.
> > 
> > Yes, it probably could be cleaned up if somebody had the time/hardware.
> > 
> > > Please suggest which way is more preferred: modifying existing
> > > drivers(of different manufacturer) or writing new driver.
> > 
> > Ususally avoiding code duplication is good, it reduces maintenance
> > burden. However, if adding the support turns out to make the original
> > code unreadable or hard to follow, a new driver might be justified. This
> > is why it is important to understand the differences of the chip as a
> > first step. (I have the feeling, that modifying is the way to go here,
> > though).
> > 
> 
> I will explore possibility of using ds1307 driver for this.
> 

Has there been any movement here?
