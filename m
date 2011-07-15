Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Jul 2011 23:57:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] dtc: Remove unused variable in flat_read_mem_reserve
Message-ID: <20110715135755.GD4368@yookeroo.fritz.box>
References: <20110628134711.GF10237@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110628134711.GF10237@zod.rchland.ibm.com>
Cc: jdl@jdl.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2011 at 09:47:11AM -0400, Josh Boyer wrote:
> The *p variable is declared and used to save inb->ptr, however p is
> later never used.  This has been the case since commit 6c0f3676 and can
> lead to build failures with -Werror=unused-but-set-variable:
> 
> 	flattree.c: In function 'flat_read_mem_reserve':
> 	flattree.c:700:14: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
> 	cc1: all warnings being treated as errors
> 	make: *** [flattree.o] Error 1
> 
> Remove the variable.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Jon, please apply.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
