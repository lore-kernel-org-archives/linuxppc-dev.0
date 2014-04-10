Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CDF9614008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 14:03:43 +1000 (EST)
Received: by mail-qa0-f44.google.com with SMTP id hw13so3336728qab.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Apr 2014 21:03:40 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1395297230-8195-1-git-send-email-xuelin.shi@freescale.com>
References: <1395297230-8195-1-git-send-email-xuelin.shi@freescale.com>
Date: Wed, 9 Apr 2014 21:03:40 -0700
Message-ID: <CAA9_cmfC=gzMerQb-3QEU8TAf-y+wK70UJaj39Ef52_tfjtTMw@mail.gmail.com>
Subject: Re: [PATCH v2] fix dmaengine_unmap failure
From: Dan Williams <dan.j.williams@intel.com>
To: xuelin.shi@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Koul, Vinod" <vinod.koul@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 11:33 PM,  <xuelin.shi@freescale.com> wrote:
> From: Xuelin Shi <xuelin.shi@freescale.com>
>
> The count which is used to get_unmap_data maybe not the same as the
> count computed in dmaengine_unmap which causes to free data in a
> wrong pool.
>
> This patch fixes this issue by keeping the map count with unmap_data
> structure and use this count to get the pool.
>
> Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
> ---
> change history:
>         v1: keep mempool pointer with unmap struct
>         v2: keep u8 map_cnt instead of mempool pointer to save mem.
>

Looks good, but please next time remember to prefix your subject line.  I.e.

"dmaengine: fix dmaengine_unmap failure"

I'll fix this up.

--
Dan
