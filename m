Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 9DFBD2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 07:59:35 +1100 (EST)
Date: Mon, 17 Dec 2012 12:59:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warning after merge of the final tree
Message-Id: <20121217125933.ec758888.akpm@linux-foundation.org>
In-Reply-To: <20121217143415.252a2f60076d1ba03807df55@canb.auug.org.au>
References: <20121217142238.a0840563304419bb345ac25f@canb.auug.org.au>
 <20121217143415.252a2f60076d1ba03807df55@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Thompson <set.mailinglist@gmail.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2012 14:34:15 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 17 Dec 2012 14:22:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the final tree, today's linux-next build (powerpc allnoconfig)
> > produced this warning:
> > 
> > warning: (PPC) selects SPARSE_IRQ which has unmet direct dependencies (HAVE_GENERIC_HARDIRQS && (IRQ_DOMAIN && DEBUG_FS || MAY_HAVE_SPARSE_IRQ))
> > 
> > I don't know what introduced that.
> 
> Actually probably caused by commit a1eaa3bc8247 ("Kconfig: fix Irq
> Subsystem menu") from the akpm tree.

kconfig-fix-irq-subsystem-menu.patch was causing various problems so I
have dropped it.
