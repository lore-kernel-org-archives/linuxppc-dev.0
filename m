Return-Path: <mmporter@cox.net>
Date: Tue, 8 Nov 2005 15:46:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Message-ID: <20051108154651.G27232@cox.net>
References: <20051107124917.C1671@cox.net>
	<20051107190128.68d41294.akpm@osdl.org>
	<20051108093759.A26086@cox.net> <200511081838.11236.sr@denx.de>
	<20051108223202.GA25185@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051108223202.GA25185@localhost.localdomain>;
	from david@gibson.dropbear.id.au on Wed, Nov 09, 2005 at
	09:32:02AM +1100
Subject: Re: 440EP FPU support missing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2005 at 09:32:02AM +1100, David Gibson wrote:
> On Tue, Nov 08, 2005 at 06:38:11PM +0100, Stefan Roese wrote:
> > In the current linux version, Bamboo (440EP) won't compile anymore, because of 
> > missing fpu support:
> > 
> > make uImage
> > ...
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/ppc/kernel/head_44x.o(.text+0x868): In function `_start':
> > : undefined reference to `KernelFP'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Somehow arch/ppc/kernel/fpu.S has disappeared. :-( I assume, this happened in 
> > the ppc/ppc64 -> powerpc merge. Any thoughts, why this file disappeared and 
> > how to solve this problem (just restore the original file)?
> 
> It's just moved to arch/powerpc/kernel/fpu.S.  All you should need is
> to tweak the Makefiles so that it's included in your build.

Actually, the version in arch/powerpc/kernel/ is older than the version
removed from arch/ppc/kernel/. It is already being built...see my other
post.

-Matt
