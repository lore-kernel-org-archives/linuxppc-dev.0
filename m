Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKP5MpSzDr4Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:13 +1000 (AEST)
In-Reply-To: <20170615185418.13980-14-javier@dowhile0.org>
To: Javier Martinez Canillas <javier@dowhile0.org>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Florian Larysch <fl@n621.de>, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>, Scott Wood <oss@buserror.net>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND, v5,
 13/16] powerpc/fsl: Add generic compatible string for I2C EEPROM
Message-Id: <3wyzKP3G5dz9s82@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 18:54:15 UTC, Javier Martinez Canillas wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
> 
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
> 
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
> 
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/226b9391d1a4e91fe08627f75ebad1

cheers
