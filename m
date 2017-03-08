Return-Path: <axboe@kernel.dk>
Received: from mail-it0-x230.google.com (mail-it0-x230.google.com
 [IPv6:2607:f8b0:4001:c0b::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdh5x4106zDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 04:56:05 +1100 (AEDT)
Received: by mail-it0-x230.google.com with SMTP id w124so16104935itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 09:56:05 -0800 (PST)
Subject: Re: [PATCH] axonram: Fix gendisk handling
To: Jan Kara <jack@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>
References: <20170308135605.4250-1-jack@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e7da115-32c8-7b80-3530-b4cf74edfa0d@kernel.dk>
Date: Wed, 8 Mar 2017 10:55:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170308135605.4250-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2017 06:56 AM, Jan Kara wrote:
> It is invalid to call del_gendisk() when disk->queue is NULL. Fix error
> handling in axon_ram_probe() to avoid doing that.
> 
> Also del_gendisk() does not drop a reference to gendisk allocated by
> alloc_disk(). That has to be done by put_disk(). Add that call where
> needed.

Applied, thanks.

-- 
Jens Axboe
