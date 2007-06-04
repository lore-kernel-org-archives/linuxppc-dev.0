Return-Path: <dgibson@ozlabs.org>
Date: Tue, 5 Jun 2007 09:49:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
Message-ID: <20070604234917.GB10877@localhost.localdomain>
References: <25445.1180941825@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25445.1180941825@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2007 at 05:23:45PM +1000, Miichael Neuling wrote:
> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.  
> 
> Specifically, if the cmdline length was >= 8 before and the new cmdline
> length is < 8, we can get corruption.

Hrm.  Have you considered using dtc for this conversion, rather than
this somewhat dubious looking fs2dt?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
