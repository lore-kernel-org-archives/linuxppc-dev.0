Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42A31DDFF6
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 03:38:21 +1000 (EST)
In-Reply-To: <1180406209.8139.13.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C8EF9444-4F73-4C1B-B21E-3EBF5A5703A9@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Tue, 29 May 2007 12:38:24 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
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


On May 28, 2007, at 21:36, Zang Roy-r61911 wrote:

> Fix the e500 v2 core reset bug.
> For e500 v2 core, a new reset control register is added to
> reset the core.
> On 85xx CDS board with e500 v2 core, normal reboot code will
> induce DDR block in u-boot. This patch fixes this bug. It is
> also tested on legacy e500 v1 core.
>
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Andy Fleming <afleming@freescale.com>
