Return-Path: <B32167@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF5C9B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 14:47:39 +1000 (EST)
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: RE: [PATCH] Add support for pt7c4338 (rtc device) in rtc-ds1307 driver
Date: Mon, 30 May 2011 04:47:26 +0000
Message-ID: <470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110526091020.GA2201@pengutronix.de>
In-Reply-To: <20110526091020.GA2201@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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



> -----Original Message-----
> From: linuxppc-dev-bounces+priyanka.jain=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+priyanka.jain=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Wolfram Sang
> Sent: Thursday, May 26, 2011 2:40 PM
> To: Jain Priyanka-B32167
> Cc: a.zummo@towertech.it; akpm@linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; rtc-linux@googlegroups.com; p_gortmaker@yahoo.com
> Subject: Re: [PATCH] Add support for pt7c4338 (rtc device) in rtc-ds1307
> driver
>=20
> On Thu, May 26, 2011 at 12:33:29PM +0530, Priyanka Jain wrote:
>=20
> > PT7C4338 chip is being manufactured by Pericom Technology Inc.
> > It is a serial real-time clock which provides:
> > 1)Low-power clock/calendar.
> > 2)Programmable square-wave output.
> > It has 56 bytes of nonvolatile RAM.
> > Its register set is same as that of rtc device: DS1307.
> >
> > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
>=20
> So it is identical to ds1307? Then why not name your platform_device
> simply 'ds1307'?
Yes, It is possible to directly use platform device 'ds1307' in device tree=
.=20
But I have one query of how to capture the information that pericom, pt7c43=
38 device is compatible with dallas, ds1307. Can it be done in somewhere in=
 some document or some code. Actually for pt7c4338 device driver, I actuall=
y started by asking if there is any already existing rtc device driver whic=
h is compatible with pericom pt7c4338 device on mailing list and as there w=
as no answer or help then, I actually ended up writing device driver for th=
at and then on the suggestion using ds1307 device driver for this.

Thanks
Priyanka
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
