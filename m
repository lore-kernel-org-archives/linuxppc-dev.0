Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C3CFEB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 12:56:17 +1100 (EST)
Date: Sun, 04 Mar 2012 20:54:09 -0500 (EST)
Message-Id: <20120304.205409.156102112320808082.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Subject: Re: [PATCH net-next] ucc_geth: separate out rx/tx ring alloc and
 free operations
From: David Miller <davem@davemloft.net>
In-Reply-To: <1330346189-25155-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330346189-25155-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 27 Feb 2012 07:36:29 -0500

> Factor out the the existing allocation and free operations
> so that they can be used individually.
> 
> This is to improve code readability, and also to prepare for
> possible future changes like better error recovery and more
> dynamic configuration (e.g on-the-fly resizing of the rings).
> 
> This change represents a straight up relocation of the existing
> code into separate routines without changing any of the contained
> code itself.  Local variables are relocated as necessary.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
