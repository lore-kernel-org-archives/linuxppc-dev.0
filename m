Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420gZw75nQzF31P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 19:40:08 +1000 (AEST)
Date: Wed, 29 Aug 2018 12:39:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: qiang.zhao@nxp.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, leoyang.li@nxp.com
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in
 ucc_get_tdm_sync_shift()
Message-ID: <20180829093948.c7nbl27ju4uszrum@mwanda>
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
 <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2018 at 02:06:45PM +0200, Mathieu Malaterre wrote:
> Where did the original go ?
> 
> https://patchwork.ozlabs.org/patch/868158/
> 
> 

Btw, we still haven't pushed a patch for this bug.

regards,
dan carpenter
