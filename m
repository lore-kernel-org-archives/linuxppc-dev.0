Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50291DDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 06:56:01 +1100 (EST)
Subject: Re: External Interrupt
From: Jon Loeliger <jdl@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47A37653.3070305@freescale.com>
References: <47A2D424.3090903@coritel.it>	<47A32C9C.3090709@ru.mvista.com>
	<47A3379F.2090004@coritel.it>	<47A33C59.4020509@ru.mvista.com>
	<47A3473D.6040505@coritel.it>  <47A37653.3070305@freescale.com>
Content-Type: text/plain
Message-Id: <1201895749.14313.13.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Feb 2008 13:55:49 -0600
Cc: Marco Stornelli <marco.stornelli@coritel.it>,
	Linuxppc Embedded Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2008-02-01 at 13:43, Scott Wood wrote:
> Marco Stornelli wrote:
> > Yes you are right. The local bus is like i2c, but I've never seen a
> > device connected with i2c and described with a sub-node of i2c node in
> > the dts file,
> 
> Grep the dts directory for "rtc@68".

But be sure to inspect /dts-v1/-ness too.

Yes, yes, yes. I have a typo fix coming... :-)

jdl
