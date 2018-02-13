Return-Path: <bkenward@solarflare.com>
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com
 [67.231.154.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zghRg5jNkzDqp2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 23:19:22 +1100 (AEDT)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
 by dispatch1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with
 ESMTP id 7EEDB45D13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 12:09:54 +0000 (UTC)
Subject: Re: [PATCH 5/5] mtd: Stop updating erase_info->state and calling
 mtd_erase_callback()
To: Boris Brezillon <boris.brezillon@bootlin.com>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, "Cyrille
 Pitchen" <cyrille.pitchen@wedev4u.fr>, <linux-mtd@lists.infradead.org>
CC: Joern Engel <joern@lazybastard.org>, Robert Jarzmik
 <robert.jarzmik@free.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kyungmin Park <kyungmin.park@samsung.com>, Artem Bityutskiy
 <dedekind1@gmail.com>, Solarflare linux maintainers
 <linux-net-drivers@solarflare.com>, Edward Cree <ecree@solarflare.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, <devel@driverdev.osuosl.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>
References: <20180212210311.23244-1-boris.brezillon@bootlin.com>
 <20180212210311.23244-6-boris.brezillon@bootlin.com>
From: Bert Kenward <bkenward@solarflare.com>
Message-ID: <b91389a7-69ef-8552-a4a9-322eca3c9108@solarflare.com>
Date: Tue, 13 Feb 2018 12:09:20 +0000
MIME-Version: 1.0
In-Reply-To: <20180212210311.23244-6-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/18 21:03, Boris Brezillon wrote:
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

For sfc parts:

Acked-by: Bert Kenward <bkenward@solarflare.com>


Thanks,

Bert.
