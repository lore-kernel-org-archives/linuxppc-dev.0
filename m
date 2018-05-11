Return-Path: <axboe@kernel.dk>
Received: from mail-pl0-x22e.google.com (mail-pl0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jN460xlVzF2K3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 07:08:36 +1000 (AEST)
Received: by mail-pl0-x22e.google.com with SMTP id w19-v6so1312691plq.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 14:08:36 -0700 (PDT)
Subject: Re: make a few block drivers highmem safe
To: Christoph Hellwig <hch@lst.de>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org
References: <20180509135948.20329-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e5f3ffef-4fa3-50d3-4fbe-d67ba2a85bd8@kernel.dk>
Date: Fri, 11 May 2018 15:08:26 -0600
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

Applied, thanks.

-- 
Jens Axboe
