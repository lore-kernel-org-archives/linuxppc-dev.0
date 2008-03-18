Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19832DE104
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:55:06 +1100 (EST)
Date: Tue, 18 Mar 2008 10:54:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] fsl_elbc_nand: fix mtd name
Message-ID: <20080318155445.GA17944@ld0162-tx32.am.freescale.net>
References: <20080318154344.GA31173@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080318154344.GA31173@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 06:43:44PM +0300, Anton Vorontsov wrote:
> With this patch applied fsl_elbc_nand chip will have proper name:
> 
>    root@b1:~# cat /proc/mtd
>    dev:    size   erasesize  name
>    mtd0: 00800000 00010000 "fe000000.flash"
>    mtd1: 02000000 00004000 "e0600000.flash"
> 
> p.s. We can't use priv->dev->bus_id as in physmap_of, because
> fsl_elbc_nand pretends to be a localbus controller, so its bus_id is
> "address.localbus", which is incorrect and thus will also not work
> for multiple chips.

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
