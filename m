Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Jul 2008 11:47:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc/boot/Makefile: change spaces to tabs
Message-ID: <20080718014731.GA11972@yookeroo.seuss>
References: <20080717181854.GB18326@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717181854.GB18326@cs181140183.pp.htv.fi>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 09:18:54PM +0300, Adrian Bunk wrote:
> For C code spaces versus tabs is just a religious issue,
> but for Makefiles it actually matters.
> 
> This patch fixes he following errors:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:166: *** missing separator.  Stop.
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:171: *** missing separator.  Stop.
> 
> Since this was inside an ifdef DTC_GENPARSER it was not a problem unless 
> someone wanted to regenerate the shipped generated files.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Oops, embarrasing mistake there.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
