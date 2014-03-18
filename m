Return-Path: <dan.j.williams@intel.com>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 231672C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 04:13:40 +1100 (EST)
Received: by mail-ve0-f176.google.com with SMTP id cz12so7233658veb.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2014 10:13:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
References: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
Date: Tue, 18 Mar 2014 10:13:36 -0700
Message-ID: <CAPcyv4gs-jos5TvfDbsaXTNebQf8VjJvbdjmjsbGZLZwZKi34g@mail.gmail.com>
Subject: Re: [PATCH] fix dmaengine_unmap failure.
From: Dan Williams <dan.j.williams@intel.com>
To: Xuelin Shi <xuelin.shi@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vinod Koul <vinod.koul@intel.com>,
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

On Tue, Mar 18, 2014 at 1:32 AM,  <xuelin.shi@freescale.com> wrote:
> From: Xuelin Shi <xuelin.shi@freescale.com>
>
> The count which is used to get_unmap_data maybe not the same as the
> count computed in dmaengine_unmap which causes to free data in a
> wrong pool.
>
> This patch fixes this issue by keeping the pool in unmap_data
> structure.

Won't this free the entire count anyways?  In what scenario is the
count different at unmap?
