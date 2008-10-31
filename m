Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Oct 2008 13:55:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2] Fix format string warning in arch/powerpc/boot/main.c
Message-ID: <20081031025522.GA18097@yookeroo.seuss>
References: <20081031025131.26406.41818.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081031025131.26406.41818.stgit@terra>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 30, 2008 at 10:51:32PM -0400, Jon Smirl wrote:
> Fix format string warning in arch/powerpc/boot/main.c
> 
>  BOOTCC  arch/powerpc/boot/main.o
> arch/powerpc/boot/main.c: In function 'prep_kernel':
> arch/powerpc/boot/main.c:65: warning: format '%08x' expects type
> 'unsigned int', but argument 3 has type 'long unsigned int'
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
