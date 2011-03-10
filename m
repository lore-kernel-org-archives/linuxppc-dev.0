Return-Path: <B32167@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8625B6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 14:24:13 +1100 (EST)
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>
Subject: RE: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Date: Thu, 10 Mar 2011 03:23:57 +0000
Message-ID: <470DB7CE2CD0944E9436E7ADEFC02FE313B1C2@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
In-Reply-To: <20110303092239.GB3649@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfram,

Though register-set looks identical but features were different. And also m=
anufacturer is different.
But still it might be possible that we can reuse ds1307.c with some modific=
ation.
But if I look at the drivers present in drivers/rtc folder. Most of them lo=
oks similar but still there are different drivers for different chips.

Please suggest which way is more preferred: modifying existing drivers(of d=
ifferent manufacturer) or writing new driver.=20

Thanks
Priyanka

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Thursday, March 03, 2011 2:53 PM
> To: rtc-linux@googlegroups.com
> Cc: linuxppc-dev@lists.ozlabs.org; a.zummo@towertech.it;
> p_gortmaker@yahoo.com; akpm@linux-foundation.org; Jain Priyanka-B32167
> Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
>=20
> Hi,
>=20
> > +/*
> > + * This file provides Date & Time support (no alarms) for PT7C4338
> chip.
> > + *
> > + * This file is based on drivers/rtc/rtc-ds1307.c
>=20
> Please explain why you can't use rtc-ds1307 directly (or with slight
> modifications). I might have missed something but the register-set looks
> identical to me?
>=20
> Regards,
>=20
>    Wolfram
>=20
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
