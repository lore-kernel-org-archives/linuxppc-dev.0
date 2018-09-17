Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DPVx54cNzF1fD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 21:47:20 +1000 (AEST)
Date: Mon, 17 Sep 2018 13:47:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.4.y] crypto: vmx - Fix sleep-in-atomic bugs
Message-ID: <20180917114715.GG13057@kroah.com>
References: <20180910074204.10812-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910074204.10812-1-omosnace@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 09:42:04AM +0200, Ondrej Mosnacek wrote:
> commit 0522236d4f9c5ab2e79889cb020d1acbe5da416e upstream.
> 
> Conflicts:
>   drivers/crypto/vmx/
>     aes_cbc.c - adapted enable/disable calls to v4.4 state
>     aes_xts.c - did not exist yet in v4.4

We don't need these lines here...  I'll go hand edit it out...
