Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A6D0B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 04:40:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBAHe21Z023648 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 10:40:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBAHiEF6009750
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 11:44:15 -0600 (CST)
Message-ID: <4B213247.7070204@freescale.com>
Date: Thu, 10 Dec 2009 11:39:19 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?5p6X5b+X5bmz?= <solyn123@gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>	
	<20091207180511.GA8914@loki.buserror.net>	
	<8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>	
	<4B2001A3.9010002@freescale.com>
	<8148211e0912100505r46a813dcgc907a79e153ca8e@mail.gmail.com>
In-Reply-To: <8148211e0912100505r46a813dcgc907a79e153ca8e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

林志平 wrote:
>         Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the
>         menuconfig, but no mpc8544ds.
> 
> 
>     mpc8544ds is supported by CONFIG_MPC85xx_DS.
>     CONFIG_MPC85XX_DS does not exist. Only mpc85xx_defconfig in
>     arch/powerpc/configs

I'm looking right at it, in arch/powerpc/platforms/85xx/Kconfig in 2.6.31.

mpc85xx_defconfig selects this option.

-Scott
