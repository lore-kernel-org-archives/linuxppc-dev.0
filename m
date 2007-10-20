Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 17:16:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 2/4] DTC: Quiet a bogus "May be used uninitialized"
	warning.
Message-ID: <20071020071632.GE26642@localhost.localdomain>
References: <E1IivsA-00078F-ST@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IivsA-00078F-ST@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 12:42:58PM -0500, Jon Loeliger wrote:
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

I don't like this one much.  The warning is indeed bogus, and my
compiler version, at least, doesn't generate it
	mulberryst:~/dtc$ gcc --version
	gcc (GCC) 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)

Putting in the initializer would mean that even on non-broken
compilers, we wouldn't get the warning if we ever changed the
contained code so that it really should generate an unitialized
variable warning.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
