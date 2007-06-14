Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A089EDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 12:31:24 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5E2VINF029421
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 19:31:19 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5E2VHNZ029917
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 21:31:18 -0500 (CDT)
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Dave Liu <r63238@freescale.com>
To: joakim.tjernlund@transmode.se
In-Reply-To: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
References: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 10:31:17 +0800
Message-Id: <1181788277.3658.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 16:22 +0200, Joakim Tjernlund wrote:
> Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> a Freescale 832x CPU gives me this:
>  ifconfig eth2 up
>  ucc_geth_startup: Can not allocate DPRAM memory for p_thread_data_tx.
>  eth2: Cannot configure net device, aborting.
>  SIOCSIFFLAGS: Cannot allocate memory
> 
> This worked in 2.6.20

Could you print the MURAM memory usage for debug?
eg. start address and size.

-d
