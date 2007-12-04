Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18261.53985.700234.923526@cargo.ozlabs.ibm.com>
Date: Wed, 5 Dec 2007 09:21:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge dtc
In-Reply-To: <1196733544.13978.201.camel@pmac.infradead.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> I think this is a bad idea -- it's hardly a difficult for those people
> who _do_ need dts to obtain it separately.

The trouble is that it's not just people who are making a kernel for a
specific embedded board that need dtc.  These days anyone who wants to
try cross-compiling a powerpc kernel and does a make allyesconfig, or
who picks cell_defconfig or ps3_defconfig to try, needs dtc if their
kernel build is to go all the way through and give them an exit status
of 0.  I can see that for people who are trying to do the right thing
and compile-test their patch across architectures, it's annoying that
powerpc has an extra external requirement when no other architecture
does, and it usually just means they don't compile-test on powerpc.

Of the various options for solving this, including dtc in the kernel
sources seems best to me.

Paul.
