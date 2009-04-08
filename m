Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7338DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 01:49:18 +1000 (EST)
Date: Thu, 9 Apr 2009 01:47:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: any place to mark various compatible strings as deprecated?
Message-ID: <20090408154728.GA9727@yookeroo.seuss>
References: <84DDF2F3-F907-4131-8C41-A9156BD5ADB2@kernel.crashing.org>
	<20090408144845.GA29163@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090408144845.GA29163@lixom.net>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 09:48:45AM -0500, Olof Johansson wrote:
> On Wed, Apr 08, 2009 at 09:23:22AM -0500, Kumar Gala wrote:
> > Do we have anywhere to list out compatible strings that are deprecated  
> > and warn if the kernel sees one?
> 
> Wouldn't dtc be a better location for that? The kernel has to be backwards
> compatible anyway, I don't really see a reason to warn there.

It should certainly be in dtc.  Whether it should also be in the
kernel is debatable.  It's also really easy to add this to dtc.  Kumar
can you point me at the ones you're thinking of, and I'll add
appropriate checks to dtc (although probably not for a couple of weeks
when I return from vacation).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
