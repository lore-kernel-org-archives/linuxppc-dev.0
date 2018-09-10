Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428CYb1YQhzF31q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 02:05:07 +1000 (AEST)
Date: Mon, 10 Sep 2018 18:04:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Matteo Croce <mcroce@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, op <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] tty: hvc: latency break regression fixes
Message-ID: <20180910160454.GA30939@kroah.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 09, 2018 at 03:39:13PM +1000, Nicholas Piggin wrote:
> Re-sending this one with the used-uinitialized warning in patch
> 3 fixed.
> 
> Greg these patches are needed to fix regressions in this merge
> window, please consider them for your tty tree.

All now queued up, thanks.

greg k-h
