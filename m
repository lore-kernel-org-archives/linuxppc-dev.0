Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 12:35:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/4] powerpc: Add gcc format warnings to zImage printf()
Message-ID: <20070322013501.GG2295@localhost.localdomain>
References: <20070321063149.ED879DDE47@ozlabs.org>
	<200703211503.l2LF3JRS008531@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703211503.l2LF3JRS008531@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:03:19AM -0600, Milton Miller wrote:
> 
> +extern int sprintf(char *buf, const char *fmt, ...) __attribute__((format(printf, 2, 3)));
> 
> you exceeded 80 columns by 10.

Revised in second spin.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
