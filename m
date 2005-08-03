Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id C574E67E11
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 23:45:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 3 Aug 2005 15:45:35 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F851C@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Vitaly,=20

> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
>
> Mentioned support should work `out-of-the box`.
> Make sure you have console=3DttyCPM0,115200 (or whatever baudrate you=20
> have) within bootargs in the U-Boot environment. U-Boot modification
is=20
> needed only if you wish to have both FEC MAC addresses configured via=20
> U-Boot env as well. Also only the related defconfig should be used.

I have the bootargs, but still nogo - even with the mpc885ads_defconfig.

Besides, in the mpc885ads_defconfig CONFIG_SCC3_ENET is set but in the
patch
description it reads as if only SCC1 is supported...

 Best Regards,

  Peter
