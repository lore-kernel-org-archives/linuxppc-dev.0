Return-Path: <B07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79C01B7BC3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jan 2010 04:28:17 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.14.3/az33egw01) with ESMTP id
	o08HSEBY003294
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jan 2010 10:28:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o08HXIS6014492
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jan 2010 11:33:18 -0600 (CST)
Message-ID: <4B476ABA.7050000@freescale.com>
Date: Fri, 08 Jan 2010 11:26:18 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dario Presti <dario.pr@tiscali.it>
Subject: Re: kernel panic on MPC8323 custom board
References: <27059752.post@talk.nabble.com> <4B46209D.5000605@freescale.com>
	<27073289.post@talk.nabble.com>
In-Reply-To: <27073289.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dario Presti wrote:
> Thanks Scott, 
> I did not find where the custom map flash driver is in the kernel source,
> where it is?

Grep your kernel tree for "MPC8323RDB Flash".

> How can I say to the kernel to use device tree instead of custom map of
> flash?

Turn off that mapping driver, and turn on CONFIG_MTD_PHYSMAP_OF.  This 
stuff was very new in 2.6.20, though, so there may be issues.  I'd 
upgrade if you can.

-Scott
