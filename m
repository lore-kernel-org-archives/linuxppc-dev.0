Return-Path: <axboe@kernel.dk>
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40h1vC5dGhzF1d1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 02:26:10 +1000 (AEST)
Received: by mail-it0-x229.google.com with SMTP id n64-v6so15406415itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 09:26:10 -0700 (PDT)
Subject: Re: make a few block drivers highmem safe
To: Christoph Hellwig <hch@lst.de>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org
References: <20180509135948.20329-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <36768a62-1b72-d7a8-8c4d-2ec66f314824@kernel.dk>
Date: Wed, 9 May 2018 10:26:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/9/18 7:59 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series converts a few random block drivers to be highmem safe,
> in preparation of eventually getting rid of the block layer bounce
> buffering support.

Series looks good to me.

-- 
Jens Axboe
