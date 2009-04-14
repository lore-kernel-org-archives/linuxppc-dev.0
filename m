Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id B3EC7DDFA0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 22:20:10 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: SunNeo <sunwx2001@hotmail.com>
Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
Date: Tue, 14 Apr 2009 14:20:04 +0200
References: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl>
	<200904141123.02495.sr@denx.de>
	<BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
In-Reply-To: <BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904141420.04478.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, U-Boot-Users <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sun,

On Tuesday 14 April 2009, SunNeo wrote:
> My platform uses the MICRON MT47H256M8THN DDRII SDRAM and the DDRII SDRAM
> is soldered on the board.
>
> As I said, my board was similar with "Kilauea" evb, so I created my
> configuration header file from Kilauea's at U-Boot. In the configuration
> file, register value for the DDR SDRAM controller is defined. But I have
> removed DDR autocalibraton related configuration from the configuration
> file, do you think this will cause any issues?

Yes, this could definitely cause some SDRAM related problems. But this is 
off-topic here. We should continue this discussion on the U-Boot mailing list 
instead (on CC). So please when you reply to this mail, remove the 
linuxppc-dev list from the recipients list.

Best regards,
Stefan
