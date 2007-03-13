Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 12:36:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 01/19] bootwrapper: Add stddef.h to ops.h
Message-ID: <20070313013623.GE29506@localhost.localdomain>
References: <20070312204138.GA28545@ld0162-tx32.am.freescale.net>
	<20070312222652.GA31268@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312222652.GA31268@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 03:26:52PM -0700, Mark A. Greer wrote:
> On Mon, Mar 12, 2007 at 02:41:38PM -0600, Scott Wood wrote:
> > ops.h references NULL, so include stddef.h, so files including ops.h
> > don't have to.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
