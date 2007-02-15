Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 143D6DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:04:43 +1100 (EST)
Message-ID: <45D48493.2020505@freescale.com>
Date: Thu, 15 Feb 2007 10:04:35 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org, g.liakhovetski@gmx.de,
	Stuart Yoder <stuart.yoder@freescale.com>
Subject: Re: [PATCH v3] powerpc: delete boot-cpu property from all DTS files
References: <11714885473600-git-send-email-timur@freescale.com>
	<20070215005323.GK16279@localhost.localdomain>
In-Reply-To: <20070215005323.GK16279@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> This looks sane to me.  If you're going about this sort of dts
> cleanup, it would be nice to remove all the linux,phandle properties
> and use dtc's reference facility to auto-generate them instead.

I wouldn't mind making a patch to do that, once my current patch is applied 
(hint hint).  However, I'd have to study-up on linux,phandle, because I don't 
know anything about it.  I just created the boot-cpu patch because someone 
around here said that that property should go, and I was doing other device-tree 
related work at the time.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
