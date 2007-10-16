Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: libfdt_env.h must be included first 
In-Reply-To: Your message of "Tue, 16 Oct 2007 13:50:34 +1000."
	<20071016035034.GP26787@localhost.localdomain>
References: <20071016035034.GP26787@localhost.localdomain> 
Date: Tue, 16 Oct 2007 07:38:12 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ihlga-0002Tw-EO@jdl.com>
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
> libfdt.h currently includes fdt.h, then libfdt_env.h.  This is
> incorrect, because depending on the environment into which libfdt is
> embedded, libfdt_env.h may be needed to define datatypes used in
> fdt.h.  This patch corrects the problem.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> I've sent this one before, but I guess it got lost in the backlog.

Sorry.  There was some froohah around it and I didn't track
where it landed.

Applied.

jdl
