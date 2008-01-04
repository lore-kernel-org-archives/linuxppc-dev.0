Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 15:07:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] Add yyerrorf() for formatted error messages.
Message-ID: <20080104040714.GB4326@localhost.localdomain>
References: <20080103234329.GA8441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080103234329.GA8441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 05:43:29PM -0600, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>

I don't really like adding any yy*() functions that aren't actually
part of the fixed lex/yacc interface.  But, despite that, let's merge
this, and parth 2/3 because I think we should get in sane include
searching for 1.1.  I'll look at polishing the message printing stuff
later.

Acked-by: David Gibson <david@ribson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
