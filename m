Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D505B6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 07:29:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5MLT0He017343
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 14:29:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5MLf7vA003505
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 16:41:08 -0500 (CDT)
Date: Tue, 22 Jun 2010 16:28:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: hellohello <hellohello008@163.com>
Subject: Re: CPM UART on MPC8270
Message-ID: <20100622212859.GA5796@schlenkerla.am.freescale.net>
References: <4C0FA73B.4070905@ge.com>
	<045f01cb0841$42bf97a0$591dbcc0@sfdomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <045f01cb0841$42bf97a0$591dbcc0@sfdomain.com>
Cc: Martyn Welch <martyn.welch@ge.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 10:04:28AM +0800, hellohello wrote:
> Although I  haven't used scc port as uart,  I think your smc1 part in your dts file maybe is wrong.
> 
> serial@11a82 { ...
>  reg = <0x11a80 0x20 0x87fc 2>;
> should be:
>   reg = <0x11a80 0x20 XXX 40>;
> XXX is the value which is set at 0x87fc in your bootloader.  
> I just got this mistake a few days ago.

"0x87fc 2" should work fine with recent kernels (and you want 0x40, not 40,
for the old way).  Besides, he said SMC1 was working, it's SCC3 that wasn't.

-Scott
