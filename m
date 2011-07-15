Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Jul 2011 23:57:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] dtc: Remove unused check variable
Message-ID: <20110715135732.GC4368@yookeroo.fritz.box>
References: <20110628124709.GC10237@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110628124709.GC10237@zod.rchland.ibm.com>
Cc: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2011 at 08:47:09AM -0400, Josh Boyer wrote:
> Commit 376ab6f2 removed the old style check functionality from DTC,
> however the check option and variable were not removed.  This leads to
> build failures when -Werror=unused-but-set-variable is specified:
> 
> 	dtc.c: In function 'main':
> 	dtc.c:102:17: error: variable 'check' set but not used [-Werror=unused-but-set-variable]
> 	cc1: all warnings being treated as errors
> 	make: *** [dtc.o] Error 1
> 	make: *** Waiting for unfinished jobs....
> 
> Remove the check variable.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Jon, please apply.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
