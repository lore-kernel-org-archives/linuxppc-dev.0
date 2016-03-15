Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPgQp2rsHzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 03:42:57 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin LaHaise <bcrl@kvack.org>, linux-next <linux-next@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: build failure after merge of the aio tree
Date: Tue, 15 Mar 2016 17:42:41 +0100
Message-ID: <5520023.cASC7FRVoJ@wuerfel>
In-Reply-To: <CAHp75VcjmDsgStAZVA=0EU4nQwCx-s+4kF_CsmSrrZtVpVg1bA@mail.gmail.com>
References: <20160315174634.6766cd88@canb.auug.org.au>
 <CAHp75VcjmDsgStAZVA=0EU4nQwCx-s+4kF_CsmSrrZtVpVg1bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 15 March 2016 16:38:51 Andy Shevchenko wrote:
> On Tue, Mar 15, 2016 at 8:46 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Benjamin,
> >
> > After merging the aio tree, today's linux-next build (powerpc
> > ppc44x_defconfig) failed like this:
> >
> > fs/built-in.o: In function `aio_thread_op_foo_at':
> > aio.c:(.text+0x4dab4): undefined reference to `__get_user_bad'
> > aio.c:(.text+0x4daec): undefined reference to `__get_user_bad'
> 
> avr32 seems affected as well and the below solution is not suitable
> (should be much more verbose in asm, I guess).
> 

ARM as well, at least for ARMv7-M.

	Arnd
