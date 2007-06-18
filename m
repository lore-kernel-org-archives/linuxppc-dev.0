Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 56B48DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 21:48:28 +1000 (EST)
Subject: Re: [PATCH] rheap: eliminates internal fragments caused by alignment
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <46766C91.6090903@freescale.com>
References: <46766C91.6090903@freescale.com>
Content-Type: text/plain
Date: Mon, 18 Jun 2007 13:48:24 +0200
Message-Id: <1182167304.2969.8.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-18 at 19:29 +0800, Li Yang wrote:
> The patch adds fragments caused by rh_alloc_align() back to free list, instead
> of allocating the whole chunk of memory.  This will greatly improve memory
> utilization managed by rheap.
> 
> It solves MURAM not enough problem with 3 UCCs enabled on MPC8323.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---

For what it is worth:
I have tested this patch and it solves the problem with 3 UCCs
as ethernet for me. This fixes a regression introduced after 2.6.20
Please consider for 2.6.22
Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se> 
