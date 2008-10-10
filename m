Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] remove bogus ppc_select syscall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200809240839.14902.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop> <200809240823.12484.arnd@arndb.de>
	<200809240839.14902.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 15:29:41 +1100
Message-Id: <1223612981.8157.146.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	paulus@samba.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 08:39 +0200, Arnd Bergmann wrote:
> The ppc_select function was introduced in linux-2.3.48 in order to support
> code confusing the legacy select() calling convention with the standard one.
> Even 11 years ago, all correctly built code should not have done this and
> could have easily been phased out. Nothing that was compiled later should
> actually try to use the old_select interface, and it would have been broken
> already on all ppc64 kernels with the syscall emulation layer.
> 
> This patch brings the 32 bit compat ABI and the native 32 bit ABI for
> powerpc into a consistent state, by removing support for both the
> old_select system call number and the handler for it.

 .../...

It's me or the patch is whitespaces damaged ?

Cheers,
Ben.
