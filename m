Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70C2568714
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 23:50:03 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17276.30957.873761.950476@home2.localdomain>
Date: Thu, 17 Nov 2005 14:34:53 +0200
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <437B56E7.5090109@ru.mvista.com>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
	<200510120859.12362.sr@denx.de> <434CB71E.5000603@compulab.co.il>
	<200510120927.56692.sr@denx.de>
	<20051012133414.7f7e2faf.ajz@cambridgebroadband.com>
	<4365BD71.9010507@compulab.co.il>
	<1131960060.7748.9.camel@hawk.pwav.net>
	<43798741.5070604@compulab.co.il>
	<D95D5881-250C-4B54-BD5A-54C79D9E0496@kernel.crashing.org>
	<437A016C.8070405@ru.mvista.com>
	<F9559612-EC8F-44BB-BA15-05DB48D4F031@kernel.crashing.org>
	<437B56E7.5090109@ru.mvista.com>
Cc: Jonathan Masel <jmasel@arabellasw.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8555 USB host support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Vitaly Bordug writes:

...

    Vitaly> I also have a bunch of patches for gregkh, supporting serial
    Vitaly> function, but they need nontrivial cleanup I do not have
    Vitaly> time currently for. So I think I grab this one together with
    Vitaly> my stuff when I head for it.

    Kumar> Also, are you aware of Freescale's driver for this?

    Vitaly> I used to try arabella one (came with MW bsp) but that
    Vitaly> version does not work with 8272.

If so, it's a very old version. The driver works with any MPC82xx (and
MPC885, BTW). Also, please remember that many Freescale ADS boards have
hardware problems (depending on the board's revision).

    Vitaly> If there are something usable, it will be interesting to
    Vitaly> look at.

...

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
