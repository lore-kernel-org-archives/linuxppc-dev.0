Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18759.14183.538947.994852@cargo.ozlabs.ibm.com>
Date: Tue, 16 Dec 2008 16:06:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/8] cleanup do_init_bootmem()
In-Reply-To: <20081209182138.12F61BBF@kernel>
References: <20081209182130.DB2150A2@kernel> <20081209182138.12F61BBF@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Hansen writes:

> I'm debating whether this is worth it. It makes this a bit more clean
> looking, but doesn't seriously enhance readability.  But, I do think
> it helps a bit.

I get this when compiling a pseries config (with the patches up to
this point applied but not 7/8 or 8/8):

  CC      arch/powerpc/mm/numa.o
/home/paulus/kernel/powerpc/arch/powerpc/mm/numa.c: In function 'do_init_bootmem_node':
/home/paulus/kernel/powerpc/arch/powerpc/mm/numa.c:949: error: 'nid' undeclared (first use in this function)
/home/paulus/kernel/powerpc/arch/powerpc/mm/numa.c:949: error: (Each undeclared identifier is reported only once
/home/paulus/kernel/powerpc/arch/powerpc/mm/numa.c:949: error: for each function it appears in.)
make[2]: *** [arch/powerpc/mm/numa.o] Error 1

Paul.
