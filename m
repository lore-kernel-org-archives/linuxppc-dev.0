Return-Path: <B32167@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 692BBB7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Feb 2011 15:12:20 +1100 (EST)
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Paul Gortmaker
	<p_gortmaker@yahoo.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH][v1] RTC driver(Linux) for PT7C4338 chip.
Date: Mon, 28 Feb 2011 04:12:09 +0000
Message-ID: <470DB7CE2CD0944E9436E7ADEFC02FE3138F51@039-SN1MPN1-003.039d.mgd.msft.net>
References: <470DB7CE2CD0944E9436E7ADEFC02FE31370D8@039-SN1MPN1-003.039d.mgd.msft.net>
	<AANLkTinQtDAo07jHNSo=wE=iRzO8hk1pQbRvBFq40TOB@mail.gmail.com>
In-Reply-To: <AANLkTinQtDAo07jHNSo=wE=iRzO8hk1pQbRvBFq40TOB@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Timur Tabi <timur.tabi@gmail.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have posted RTC driver patch back in October, 2010 with reminders for rev=
iew in between but still waiting for review and acknowledgement.
Linux Maintainer list suggests Alessandro and Paul as maintainer which are =
already in To-- list.
Please let me know what else I need to do to get it review and acknowledge.

Thanks
Priyanka




> -----Original Message-----
> From: Timur Tabi [mailto:timur.tabi@gmail.com]
> Sent: Thursday, February 24, 2011 1:41 AM
> To: Alessandro Zummo
> Cc: Jain Priyanka-B32167; Paul Gortmaker; rtc-linux@googlegroups.com;
> linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Gupta Maneesh-B18878;
> Aggrwal Poonam-B10812
> Subject: Re: [PATCH][v1] RTC driver(Linux) for PT7C4338 chip.
>=20
> On Wed, Feb 23, 2011 at 4:00 AM, Jain Priyanka-B32167
> <B32167@freescale.com> wrote:
> > Hi,
> >
> > =A0Please review and acknowledge this patch.
>=20
> Alessandro,
>=20
> Aren't you the RTC maintainer?  Priyanka has been asking for months for
> you to review and ack this patch, and then pick up for the next kernel
> release.  Is there something else that she needs to do to get your
> attention?  You can find it in patchworks here:
>=20
> http://patchwork.ozlabs.org/patch/69206/
>=20
> Notice that it was originally posted back in October, so it could have
> been included in 2.6.38.
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
