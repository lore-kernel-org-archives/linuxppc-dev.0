Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/16] [powerpc] Use udbg_early_init() on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213061024.7BB35DDD0C@ozlabs.org>
References: <20070213061024.7BB35DDD0C@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 17:22:16 +1100
Message-Id: <1171347737.20192.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:10 +1100, David Gibson wrote:
> udbg_early_init() is a function used on 64 bit systems, which
> initializes whichever early udbg backend is configured.  This function
> is not called on 32-bit, however if btext early debug is enabled it
> does have an explicit, inline, #ifdef-ed assignment performing
> analagous initialization.
> 
> This patch makes things more uniform by folding the btext
> initialization as an option into udbg_early_init() and calling that
> from the 32-bit setup path.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
