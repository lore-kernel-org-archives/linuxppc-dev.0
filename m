Return-Path: <compudj@krystal.dyndns.org>
Received: from toq7-srv.bellnexxia.net (wynq.bellnexxia.net [209.226.175.203])
	by ozlabs.org (Postfix) with ESMTP id 81F39DDFBC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 22:45:47 +1000 (EST)
Received: from toip7.srvr.bell.ca ([209.226.175.124])
	by tomts16-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080423121428.JDGA1723.tomts16-srv.bellnexxia.net@toip7.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 08:14:28 -0400
Date: Wed, 23 Apr 2008 08:14:26 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Kyle McMartin <kyle@mcmartin.ca>,
  Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC patch 6/9] POWERPC remove -traditional
Message-ID: <20080423121426.GA25947@Krystal>
References: <20080422172404.502954084@polymtl.ca>
	<20080422172842.427209743@polymtl.ca>
	<18446.48624.515912.541936@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18446.48624.515912.541936@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Paul Mackerras (paulus@samba.org) wrote:
> Mathieu Desnoyers writes:
> > Subject: [RFC patch 6/9] Re: [PATCH] Stringify support commas
> >  > This is a no-no for those archs that still use -traditional.
> >  > > I dunno if this is a problem for you at the moment and the
> >  > > right fix is anyway to nuke -traditional.
> >  > > 
> >  > >     Sam
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > CC: Sam Ravnborg <sam@ravnborg.org>
> > CC: paulus@samba.org
> > CC: linuxppc-dev@ozlabs.org
> > ---
> >  arch/powerpc/boot/Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Looks OK.  I'll put it in my tree.
> 
> Paul.

OK, although it won't be needed with v2 of the stringify with commas.
There seems to be some important details which differ between
-traditional and stdc gcc operation which makes it non-trivial to remove
the -traditional, at least on sparc. Maybe Kyle could tell us a bit more
about the nature of these limitations ?

I would wait a bit before merging until we at least identify what those
limitations are.

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
