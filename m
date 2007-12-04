Return-Path: <SRS0+d99126679a6468e47a3e+1563+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: Merge dtc
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18261.53985.700234.923526@cargo.ozlabs.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 22:33:53 +0000
Message-Id: <1196807633.13978.383.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-12-05 at 09:21 +1100, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > I think this is a bad idea -- it's hardly a difficult for those people
> > who _do_ need dts to obtain it separately.
> 
> The trouble is that it's not just people who are making a kernel for a
> specific embedded board that need dtc.  These days anyone who wants to
> try cross-compiling a powerpc kernel and does a make allyesconfig, or
> who picks cell_defconfig or ps3_defconfig to try, needs dtc if their
> kernel build is to go all the way through and give them an exit status
> of 0.  I can see that for people who are trying to do the right thing
> and compile-test their patch across architectures, it's annoying that
> powerpc has an extra external requirement when no other architecture
> does, and it usually just means they don't compile-test on powerpc.
> 
> Of the various options for solving this, including dtc in the kernel
> sources seems best to me.

Make vmlinux the default target instead of zImage would seem like a
better answer. I'm surprised that it isn't like that already, in fact --
and I'm only inferring that it isn't from your message. I always thought
that if I typed 'make' I got the vmlinux and not a zImage.

-- 
dwmw2
