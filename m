Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 10:22:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC patches
Message-ID: <20080520002225.GC22279@yookeroo.seuss>
References: <E1JyAwJ-0004Fz-9A@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JyAwJ-0004Fz-9A@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 02:22:31PM -0500, Jon Loeliger wrote:
> 
>     dtc: Simplify error handling for unparseable input [resend]
>     dtc: Clean up included Makefile fragments [resend]
>     dtc: Trivial formatting fixes [resend]
>     dtc: Make dt_from_blob() open its own input file, like the other input formats [resend]
>     dtc: Rework handling of boot_cpuid_phys [resend]
> 
> All applied and pushed out.

Thanks.

>     dtc: Rework handling of boot_cpuid_phys [resend]
>                                             ^
>                                             |
> Please don't do this -----------------------+
> 
> This forced an edit of each commit message by hand.
> If you are going to do this, do this instead:
> 
>     Subject: [resend] dtc: Rework handling of boot_cpuid_phys

Oops. sorry.

This leaves one outstanding dtc patch from me; the v0 to v1 conversion
program.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
