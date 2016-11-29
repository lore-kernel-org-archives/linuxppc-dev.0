Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tStDz1NHWzDvtD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 06:01:23 +1100 (AEDT)
Date: Tue, 29 Nov 2016 20:01:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Geoff Levand <geoff@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/ps3: Fix system hang with GCC 5 builds
Message-ID: <20161129190131.GA14409@kroah.com>
References: <0778d754-b261-9d69-d309-a12970ce1cfa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0778d754-b261-9d69-d309-a12970ce1cfa@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2016 at 10:47:32AM -0800, Geoff Levand wrote:
> GCC 5 generates different code for this bootwrapper null check
> that causes the PS3 to hang very early in its bootup.  This
> check is of limited value, so just get rid of it.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/powerpc/boot/ps3-head.S | 5 -----
>  arch/powerpc/boot/ps3.c      | 8 +-------
>  2 files changed, 1 insertion(+), 12 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
