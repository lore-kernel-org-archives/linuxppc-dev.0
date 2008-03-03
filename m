Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 775D6DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 03:42:37 +1100 (EST)
Message-ID: <47CC2A76.4020204@freescale.com>
Date: Mon, 03 Mar 2008 10:42:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Angelo <s104259@yahoo.it>
Subject: Re: I2S driver
References: <529490.33431.qm@web23110.mail.ird.yahoo.com>
In-Reply-To: <529490.33431.qm@web23110.mail.ird.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Angelo wrote:
> Hi my name is Angelo.
> 
> I'm working on I2S driver, on MPC5200b board.
> Does anyone tell me where i can found some information on HOW to write it?

I wrote an ASoC driver for the MPC8610, which also has an I2S interface.  You
can find it in sound/soc/fsl.

-- 
Timur Tabi
Linux kernel developer at Freescale
