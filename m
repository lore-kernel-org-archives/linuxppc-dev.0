Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Feb 2007 18:21:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 2/3] zImage: Cleanup and improve prep_kernel()
Message-ID: <20070218072109.GA1859@localhost.localdomain>
References: <20070216062739.62AE8DDD08@ozlabs.org>
	<45D7AA4B.2020004@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D7AA4B.2020004@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 05:22:19PM -0800, Geoff Levand wrote:
> David Gibson wrote:
> > This patch rewrites prep_kernel() in the zImage wrapper code to be
> > clearer and more flexible.  Notable changes:
> 
> > --- working-2.6.orig/arch/powerpc/boot/main.c
> 
> > +struct elf_info {
> > +	unsigned long loadsize;
> > +	unsigned long memsize;
> > +	unsigned long elfoffset;
> > +} vmlinux;
> 
> 
> This global instance (vmlinux) doesn't seem to be used anywhere, so
> it can be removed.

Oh, yes.  Oops, that's a leftover from an intermediate version.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
