Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E8FD067A45
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 17:42:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j5S7gJa6139624
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 07:42:19 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j5S7gJqx117774
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 09:42:19 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j5S7gI3v000314
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 09:42:19 +0200
In-Reply-To: <1119847159.5133.106.camel@gaston>
References: <1119847159.5133.106.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 28 Jun 2005 09:43:02 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> powerbooks have, CONFIG_PM for power management related code, and just
> left out of any CONFIG_* option for some generally useful stuff that 
> can
> be used on non-laptops as well.

Is there any real reason not to enable CONFIG_PM on all Macs?


Segher
