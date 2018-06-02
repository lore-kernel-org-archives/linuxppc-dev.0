Return-Path: <SRS0=E1Is=IU=linuxfoundation.org=gregkh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yhg33zzWzF13P
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:21:31 +1000 (AEST)
Date: Sat, 2 Jun 2018 15:21:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.14 2/4] powerpc/mm/slice: create header files dedicated
 to slices
Message-ID: <20180602132107.GH31493@kroah.com>
References: <170bd2b5b5cb1e474599165e8f21f121225a2df9.1527755908.git.christophe.leroy@c-s.fr>
 <798b787d74d94b5d29f1c0279bad157b6b5df7ec.1527755908.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <798b787d74d94b5d29f1c0279bad157b6b5df7ec.1527755908.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 31, 2018 at 08:54:52AM +0000, Christophe Leroy wrote:
> [ Upstream commit a3286f05bc5a5bc7fc73a9783ec89de78fcd07f8 ]
> 
> In preparation for the following patch which will enhance 'slices'
> for supporting PPC32 in order to fix an issue on hugepages on 8xx,
> this patch takes out of page*.h all bits related to 'slices' and put
> them into newly created slice.h header files.
> While common parts go into asm/slice.h, subarch specific
> parts go into respective books3s/64/slice.c and nohash/64/slice.c
> 'slices'
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/slice.h | 27 ++++++++++++++
>  arch/powerpc/include/asm/nohash/64/slice.h | 12 ++++++
>  arch/powerpc/include/asm/page.h            |  1 +
>  arch/powerpc/include/asm/page_64.h         | 59 ------------------------------
>  arch/powerpc/include/asm/slice.h           | 40 ++++++++++++++++++++
>  5 files changed, 80 insertions(+), 59 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/slice.h
>  create mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
>  create mode 100644 arch/powerpc/include/asm/slice.h

This patch does not apply :(

Can you fix this series up and resend the whole thing?

thanks,

greg k-h
