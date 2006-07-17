Return-Path: <jotken@softadvances.com>
Received: from elasmtp-galgo.atl.sa.earthlink.net
	(elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id 4EE3567B7D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 21:02:58 +1000 (EST)
Message-ID: <44BB6E49.3030505@softadvances.com>
Date: Mon, 17 Jul 2006 06:02:33 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: uboot environment variables size for Yosemite board.
References: <20060717070018.21ED1353C61@atlas.denx.de>
In-Reply-To: <20060717070018.21ED1353C61@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Wolfgang Denk wrote:
> In message <FAB00A8DC59FAB42B13C2B3B0F6877010D14478B@ehost011-3.exch011.intermedia.net> you wrote:
>> I'm using uboot-1.1.4 for AMCC PPC440E Yosemite board. I've downloaded
> 
> Note that this is off topic here. You should have posted this on  the
> U-Boot-Users mailing list instead.
> 
>> this uboot from DENX site. It uses EEPROM to store environment
>> variables. Since EEPROM on Yosemite board is only 512 bytes, there can
>> not be more environment variables which is not very convenient.
> 
> Thisi s wrong. The Yosemite configuration uses (like most (all?) AMCC
> eval boards - two redundand flash sectors to store  the  environment.
> And available environment size is 8 kB:

He has an older Yosemite.  The original Yosemite U-Boot used the EEPROM
for environment variables.

> 	=> print
> 	...
> 	Environment size: 1355/8187 bytes
> 
>> There is theoretical possibility to save these variables on flash (64M
>> from which I use only part) and yosemite.h header file even has defines,
>> allowing this option. But is it going work in reality? What is simplest
>> way for Yosemite board to increase environment variables storage space?
> 
> I have no idea where you got your board configuration from, but it is
> definitely   not   current   code,   nor   the   binary   image    at
> ftp://ftp.denx.de/pub/u-boot/images/amcc/yosemite/u-boot.bin
> 
> The current code does use (redundand) flash for environment storage.
> 
> Best regards,
> 
> Wolfgang Denk
> 
