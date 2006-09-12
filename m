Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D85679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 03:48:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to find I2C address?
Date: Tue, 12 Sep 2006 10:48:50 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE02FFFA1D@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "Sachin Rane" <SRane@alphion.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On Tue, 2006-09-12 at 10:13 -0400, Sachin Rane wrote:
> Hi,
> =20
> I am using AMCC PPC440GX evaluation board.
> I want to access serial EEPROM (AP31_U29) present on the board.
> I couldn't find the I2C address for this chip in the board manuals.
> =20
> Could you tell me where I can find it?
> =20

You didn't look very hard.  All of the I2C addresses are in Table 2-5 on
page 42 of the AMCC evaluation board users manual.

Marc Howard
