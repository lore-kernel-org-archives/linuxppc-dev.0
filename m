Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE104DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:18:34 +1000 (EST)
Message-ID: <466EC752.1010207@freescale.com>
Date: Tue, 12 Jun 2007 11:18:26 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
In-Reply-To: <1181639293.8953.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zang Roy-r61911 wrote:
> From: roy zang <tie-fei.zang@freescale.com>
> 
> Fix the reset bug on 8548CDS board.
>>From MPC8548CDS with e500 v2 core, a new reset control register is added.
> This register is used for the cpu reset.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
