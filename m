Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0618ADDFD2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 15:20:28 +1000 (EST)
Date: Tue, 21 Apr 2009 15:17:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Move dtc and libfdt sources from arch/powerpc/boot to scripts/dtc
Message-ID: <20090421051751.GA23934@yookeroo.seuss>
References: <18906.57833.843101.770634@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18906.57833.843101.770634@drongo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, Michal Simek <monstr@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 03:17:29PM +1000, Paul Mackerras wrote:
> David Gibson writes:
> 
> > The vast bulk of this patch is a literal move, the rest is adjusting
> > the various Makefiles to use dtc and libfdt correctly from their new
> > locations.
> 
> Did you test this with a separate object directory?  I get:

Ugh.  Obviously not.  New patch coming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
