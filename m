Return-Path: <dgibson@ozlabs.org>
Date: Sat, 5 Jan 2008 23:20:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] Add support for binary includes.
Message-ID: <20080105122043.GG4326@localhost.localdomain>
References: <20080104211043.GA28991@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080104211043.GA28991@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, Jan 04, 2008 at 03:10:43PM -0600, Scott Wood wrote:
> A property's data can be populated with a file's contents
> as follows:
> 
> node {
> 	prop = /incbin/("path/to/data");
> };
> 
> A subset of a file can be included by passing start and size parameters.
> For example, to include bytes 8 through 23:
> 
> node {
> 	prop = /incbin/("path/to/data", 8, 16);
> };

Hrm.  Can we leave this one until after 1.1?   Since it adds new
syntax, I think it would be worth cogitating a bit longer.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
