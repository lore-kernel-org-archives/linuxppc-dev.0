Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 4CC9E67C90
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 01:08:51 +1000 (EST)
Message-ID: <44EC6F81.9050101@mdivac.com>
Date: Wed, 23 Aug 2006 11:08:49 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: TEMAC problem on ML403 with U-boot.
References: <BAY110-F391AE6DCE84284F62F4FEAB2460@phx.gbl>
In-Reply-To: <BAY110-F391AE6DCE84284F62F4FEAB2460@phx.gbl>
Content-Type: text/plain; charset=GB2312
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
> In your ML403 design which is booted by U-boot, do you use the normal
> 10/100M Enet MAC or TEMAC? Is TEMAC supported by U-Boot 1.1.4? In my
> design I use TEMAC and it works well when I boot my Linux directly
> using Xilinx EDK bootloader. However it fails when using U-boot......
>
> Thanks for your telling.
>
> Regards
> Ming
>
> _________________________________________________________________
> 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com
>
Ming,

The ML403 reference design from Xilinx uses the 10/100 Ethernet MAC and
works with U-Boot 1.1.4. The Xilinx GSRD design uses the ll_temac and it
does not work with U-Boot. We have decided that it would not be worth
the effort to port the ll_temac driver to work with U-Boot. However, if
anybody has done so, I would be interested.

Frank
