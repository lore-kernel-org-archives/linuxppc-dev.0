Return-Path: <sr@denx.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id E03B968662
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 03:21:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 1 Nov 2005 17:01:50 +0100
References: <43678A3A.1050803@softplc.com>
In-Reply-To: <43678A3A.1050803@softplc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511011701.51134.sr@denx.de>
Cc: Dick Hollenbeck <dick@softplc.com>
Subject: Re: AMCC440EP Boot Source
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dick,

On Tuesday 01 November 2005 16:31, Dick Hollenbeck wrote:
> We are looking at the yosemite design but want a CF2 socket for the OS
> image.   Can U-Boot reside in the EEPROM accessible via I2C?

No. 440EP definitely can't boot from I2C EEPROM! With CF2 you mean 
CompactFlash, right?

> This would allow us to remove the flash entirely in favor of the CF2
> flash.  If yes, are there any drawbacks to this vs. keeping a small bit
> of flash soldered to the board?

Keep the small NOR FLASH and save yourself a lot of trouble. 256kB is enough 
in most cases.

By the way: This is off topic here and should be asked in the U-Boot list.

Best regards,
Stefan
