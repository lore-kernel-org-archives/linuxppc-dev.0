Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id D1C60689DD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 21:21:06 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
Date: Thu, 26 Jan 2006 11:20:47 +0100
References: <43CC3E37.4040707@softadvances.com>
	<20060125185131.GA7425@gate.ebshome.net>
	<43D7D334.3070709@ovro.caltech.edu>
In-Reply-To: <43D7D334.3070709@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601261120.48251.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 25 January 2006 20:36, David Hawkins wrote:
> I haven't looked for it yet, but do you know if there is a driver
> for the Yosemite board I2C temperature sensor already written?

The Analog Devices AD7414 is used on Yosemite/Yellowstone and it doesn't seem 
to be supported from the lm-sensors project right now. Shouldn't be that 
difficult to write a driver for it though.

Best regards,
Stefan
