Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Feb 2007 10:54:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH] powerpc 405 : remove 4xx platform from Makefile
Message-ID: <20070205235426.GA20123@localhost.localdomain>
References: <20070205202011.GA13694@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205202011.GA13694@Krystal>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 03:20:11PM -0500, Mathieu Desnoyers wrote:
> powerpc 405 : remove 4xx platform from Makefile
> 
> Having an empty arch/powerpc/platforms/4xx (no object) causes a linking
> error. To correct this, 4xx must be removed from the upper level
> Makefile (just like 8xx).

I don't think there's any point to this.  4xx is broken anyway in
arch/powerpc at present.  When it's fixed (which I'm working on now),
that directory will no longer be empty.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
