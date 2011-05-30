Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE017.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7960DB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 00:30:06 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: Re: [rtc-linux] Re: [PATCH] Add support for pt7c4338 (rtc device)
	in rtc-ds1307 driver
Date: Mon, 30 May 2011 14:29:58 +0000
Message-ID: <BANLkTi=H2rHSjTvRK5+SPhW26qCNUBMxbA@mail.gmail.com>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110526091020.GA2201@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110530082429.GA3409@pengutronix.de>
In-Reply-To: <20110530082429.GA3409@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	Jain Priyanka-B32167 <B32167@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2011 at 3:24 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:

> The first place where this should be mentioned is the datasheet of the
> pt-chip, so you might ask the producer to add this information (don't
> expect much to happen, though).

It's true that the data sheet does not mention that it's identical to
the DS1307, but that's still no excuse for not noticing it and writing
a whole driver for it.  :-(

> IIRC I asked you explicitly for the differences between the chips. If
> there are none, you can use the driver directly, right? :)

Yes.  The device tree node for the PT7C4338 device should just say

   /* The board has a PT7C4338, which is compatible with the DS1307 */
   compatible =3D "dallas,ds1307";

And that's it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
