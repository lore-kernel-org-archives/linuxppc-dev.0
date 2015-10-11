Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 469A41A05B5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 23:41:58 +1100 (AEDT)
Subject: Re: [PATCH 1/2] net/fsl_pq_mdio: check TBI address for consistency
 with mapped range
To: Gerlando Falauto <gerlando.falauto@keymile.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ogabbay@advaoptical.com, bigeasy@linutronix.de,
 "David S. Miller" <davem@davemloft.net>,
 Andy Fleming <afleming@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
 <1444403708-16576-1-git-send-email-gerlando.falauto@keymile.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <561A5910.1070202@tabi.org>
Date: Sun, 11 Oct 2015 07:41:52 -0500
MIME-Version: 1.0
In-Reply-To: <1444403708-16576-1-git-send-email-gerlando.falauto@keymile.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gerlando Falauto wrote:
>
> Change-Id: If1e7d8931f440ea9259726c36d3df797dda016fb

You need to remove these from patches that are emailed, and fix the 
pointer type comparison.

Otherwise,

Acked-by: Timur Tabi <timur@tabi.org>
