Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E413DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:00:08 +1000 (EST)
Message-ID: <467068E1.8060107@freescale.com>
Date: Wed, 13 Jun 2007 17:00:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
References: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> a Freescale 832x CPU gives me this:
>  ifconfig eth2 up
>  ucc_geth_startup: Can not allocate DPRAM memory for p_thread_data_tx.
>  eth2: Cannot configure net device, aborting.
>  SIOCSIFFLAGS: Cannot allocate memory

It's possible that there isn't enough MURAM for three QE ethernet interfaces.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
