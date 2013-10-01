Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 16:18:19 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH] powerpc: fix section mismatch warning in free_lppacas
Message-ID: <20131001061818.GE17966@concordia>
References: <1380458478-2324-1-git-send-email-murzin.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380458478-2324-1-git-send-email-murzin.v@gmail.com>
Cc: geoff@infradead.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 29, 2013 at 02:41:18PM +0200, Vladimir Murzin wrote:
> While cross-building for PPC64 I've got bunch of
> 
> WARNING: arch/powerpc/kernel/built-in.o(.text.unlikely+0x2d2): Section
> mismatch in reference from the function .free_lppacas() to the variable
> .init.data:lppaca_size The function .free_lppacas() references the variable
> __initdata lppaca_size. This is often because .free_lppacas lacks a __initdata
> annotation or the annotation of lppaca_size is wrong.
> 
> Fix it by using proper annotation for free_lppacas. Additionally, annotate
> {allocate,new}_llpcas properly.

Yep looks good.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers
