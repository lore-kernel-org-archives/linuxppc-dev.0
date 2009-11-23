Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC74DB6F01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 01:59:26 +1100 (EST)
Subject: Re: [PATCH 1/3] eLBC NAND: increase bus timeout to maximum
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20091113201216.GA8313@loki.buserror.net>
References: <20091113201216.GA8313@loki.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Nov 2009 16:36:31 +0200
Message-Id: <1258986991.18407.14.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-13 at 14:12 -0600, Scott Wood wrote:
> When a NAND operation is in progress, all other localbus operations
> (including NOR flash) will have to wait for access to the bus.  However, the
> NAND operation may take longer to complete than the default timeout.  Thus,
> if NOR is accessed while a NAND operation is in progress, the NAND operation
> will fail.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Taken the patches to my l2-mtd-2.6 tree.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
