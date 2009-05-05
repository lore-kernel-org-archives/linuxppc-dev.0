Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8DFD3DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 01:52:33 +1000 (EST)
Message-ID: <4A0060B4.8010402@freescale.com>
Date: Tue, 05 May 2009 10:52:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Landau, Bracha" <BLandau@nds.com>
Subject: Re: help with MPC8272ADS board
References: <065A7D06F7D4E546A18E80E08D066E18118931C627@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18118931C627@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Landau, Bracha wrote:
> I've upgraded to the latest kernel (2.6.29), and after updating the configuration the cuImage did boot.
> What's the difference between the address for the early debug console for cuImage and uImage + blob?

The address is wherever the previous driver (u-boot or bootwrapper) put 
the transmit descriptor.  The default address matches what Linux's 
bootwrapper uses, but u-boot is a bit different (IIRC it's DPRAM+0x88).

-Scott
