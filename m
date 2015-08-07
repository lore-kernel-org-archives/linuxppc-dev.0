Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 901E41A1BFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 05:46:52 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 15:46:50 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 114D66E804B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 15:38:33 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t77Jkldd66650214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 19:46:47 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t77Jkk4H024129
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 15:46:47 -0400
Message-ID: <55C50B23.7000101@linux.vnet.ibm.com>
Date: Fri, 07 Aug 2015 14:46:43 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrzej Hajda <a.hajda@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 06/31] arch/powerpc/pseries: use kmemdup rather than
 duplicating its implementation
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
 <1438934377-4922-7-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1438934377-4922-7-git-send-email-a.hajda@samsung.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2015 02:59 AM, Andrzej Hajda wrote:
> The patch was generated using fixed coccinelle semantic patch
> scripts/coccinelle/api/memdup.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2014320
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
