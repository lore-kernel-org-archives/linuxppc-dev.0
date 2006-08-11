Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 9F09C67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 01:14:27 +1000 (EST)
Message-ID: <44DC9ECF.7030301@mdivac.com>
Date: Fri, 11 Aug 2006 11:14:23 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: U-boot on ML403
References: <BAY110-F31F8E978C237CACA6523FB24A0@phx.gbl>
In-Reply-To: <BAY110-F31F8E978C237CACA6523FB24A0@phx.gbl>
Content-Type: text/plain; charset=gb2312
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

Ming Liu wrote:
> Dear Frank,
> I know you are using U-boot on ML403 now. So can you say something
> about how to configure U-boot as ML403 board? I noticed that in U-boot
> 1.1.4, there is only ML300 supported. So if I want to configure the
> board as ML403 and some other customed options(e.g. no EEPROM), what
> shall I do? Thanks for your help.
>
> Regards
> Ming
>

Ming,

I received an updated version of the Xilinx xapp542 directly from
Xilinx. We had to sign a non-disclosure agreement before they would send
it to me. This update provided the necessary pieces to allow XPS to
generate a U-Boot "BSP" and a modified U-Boot tree with support for
additional mlXXX boards.

I would recommend contacting Xilinx for this. Sorry I can't be of
greater assistance.

Frank
