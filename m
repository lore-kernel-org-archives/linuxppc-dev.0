Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6B6DDE4D5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:11:48 +1100 (EST)
Date: Tue, 18 Mar 2008 11:11:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2] fsl_elbc_nand: fix mtd name
Message-ID: <20080318161139.GD17944@ld0162-tx32.am.freescale.net>
References: <20080318154344.GA31173@localhost.localdomain>
	<20080318155814.GA5223@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080318155814.GA5223@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 06:58:14PM +0300, Anton Vorontsov wrote:
> Oops, forgot the NULL checking.
[snip] 
> +	if (priv->mtd.name)
> +		kfree(priv->mtd.name);
> +

Not needed; kfree(NULL) is a no-op.

-Scott
