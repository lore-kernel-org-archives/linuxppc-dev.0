Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 May 2007 10:34:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Move reg_booke.h to include/asm-powerpc
Message-ID: <20070510003452.GA483@localhost.localdomain>
References: <11787390792190-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11787390792190-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 02:31:19PM -0500, Becky Bruce wrote:
> This patch moves reg_booke.h from include/asm-ppc to
> include/asm-powerpc.  This is just a git-mv of the file; no changes
> were made.  Tested builds of 8540 ADS and Ebony platforms with
> ARCH=ppc and ARCH=powerpc.

I'd much prefer if we copied rather than moved it to asm-powerpc.  I'm
hoping we can get rid of the remaining sharing of include files shared
between ppc and powerpc.  That way we can do cleanups in powerpc
without worrying about breaking ppc.  In turn that should expedite
progress towards ditching arch/ppc entirely.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
