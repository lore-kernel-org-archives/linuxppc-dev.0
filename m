Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Accept NOPs in dtb input regardless of version 
In-Reply-To: Your message of "Tue, 26 Jun 2007 11:30:47 +1000."
	<20070626013047.GB4383@localhost.localdomain>
References: <20070626013047.GB4383@localhost.localdomain> 
Date: Mon, 25 Jun 2007 21:44:59 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I3135-0005NF-AL@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Since Milton's patch, dtc will accept (and, correctly, ignore) NOP
> tags when given dtb input v16 or later.  However, although NOPs
> weren't defined in earlier versions, they're not ambiguous, so should
> be accepted there as well.  This patch does so, printing a mere
> warning when finding NOPs in a too-early dtb version.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
