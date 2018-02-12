Return-Path: <richard@nod.at>
Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKl30JyfzF0RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:16:30 +1100 (AEDT)
From: Richard Weinberger <richard@nod.at>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org,
 Joern Engel <joern@lazybastard.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Edward Cree <ecree@solarflare.com>, Bert Kenward <bkenward@solarflare.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, devel@driverdev.osuosl.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 5/5] mtd: Stop updating erase_info->state and calling
 mtd_erase_callback()
Date: Mon, 12 Feb 2018 23:17:41 +0100
Message-ID: <1709914.WnqyHBqgHQ@blindfold>
In-Reply-To: <20180212210311.23244-6-boris.brezillon@bootlin.com>
References: <20180212210311.23244-1-boris.brezillon@bootlin.com>
 <20180212210311.23244-6-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 12. Februar 2018, 22:03:11 CET schrieb Boris Brezillon:
> MTD users are no longer checking erase_info->state to determine if the
> erase operation failed or succeeded. Moreover, mtd_erase_callback() is
> now a NOP.
> 
> We can safely get rid of all mtd_erase_callback() calls and all
> erase_info->state assignments. While at it, get rid of the
> erase_info->state field, all MTD_ERASE_XXX definitions and the
> mtd_erase_callback() function.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
