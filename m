Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B533B7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 14:15:44 +1000 (EST)
Subject: Re: U-boot support for MPC85xx eSPI
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <DA601BED1671C24093F284F75082C9934B68EB@rtpwbee01.SIXIS.NS>
Date: Tue, 20 Apr 2010 23:15:26 -0500
Message-Id: <6E565AB2-EAAD-4395-9E38-6759FA36125A@kernel.crashing.org>
References: <DA601BED1671C24093F284F75082C9934B68EB@rtpwbee01.SIXIS.NS>
To: "Hillery, Nathan" <nhillery@sixisinc.com>
Cc: U-Boot-Users ML <u-boot@lists.denx.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 20, 2010, at 1:24 PM, Hillery, Nathan wrote:

> I=92m looking for U-boot support for the embedded SPI driver on the =
MPC8536 to access a SPI flash device (Numonyx [ex-STmicro] M25P16).  The =
eSPI can read the SPI flash (that=92s how U-boot gets loaded into RAM) =
and I can read/write from linux using the mtdblock driver.  I see code =
that appears to support the MPC83xx, but it looks quite different than =
the MPC85xx.  I am willing to backport the linux code to work in U-boot, =
but am hoping that isn=92t necessary.

This is really a u-boot list question.  (u-boot@lists.denx.de)

- k=
