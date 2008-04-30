Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id 1B5B0DDFFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 04:58:19 +1000 (EST)
Received: from midway.site ([72.90.125.186]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 11:48:09 -0700
Date: Wed, 30 Apr 2008 11:48:08 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docbook: fix fatal rapidio yet again (and more to come)
Message-Id: <20080430114808.64e2f40b.rdunlap@xenotime.net>
In-Reply-To: <20080430113500.dfe21880.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
	<20080430113500.dfe21880.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 11:35:00 -0700 Andrew Morton wrote:

> On Tue, 29 Apr 2008 20:10:55 -0700 (PDT)
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Don't refer to file that no longer exists:
> > docproc: linux-2.6.25-git14/arch/powerpc/kernel/rio.c: No such file or directory
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  Documentation/DocBook/rapidio.tmpl |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > --- linux-2.6.25-git14.orig/Documentation/DocBook/rapidio.tmpl
> > +++ linux-2.6.25-git14/Documentation/DocBook/rapidio.tmpl
> > @@ -133,7 +133,6 @@
> >  !Idrivers/rapidio/rio-sysfs.c
> >       </sect1>
> >       <sect1 id="PPC32_support"><title>PPC32 support</title>
> > -!Iarch/powerpc/kernel/rio.c
> >  !Earch/powerpc/sysdev/fsl_rio.c
> >  !Iarch/powerpc/sysdev/fsl_rio.c
> >       </sect1>
> 
> grumble.
> 
> This is a subset of rapidio-fix-docbook-references.patch, but I appear to
> be unable to interest anyone in merging/reviewing/accepting/anything-else
> that quite large set of patches.
> 
> Guys, those patches were sent six weeks ago and it now looks like they will
> miss 2.6.26.  This is pretty slack of us.  Help?

There's nothing there that can hurt.  (famous last words)

Just merge it.

---
~Randy
