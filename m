Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45CBA689FC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 21:25:49 +1100 (EST)
Date: Wed, 11 Jan 2006 11:25:40 +0100
From: Olaf Hering <olh@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20060111102540.GA11688@suse.de>
References: <200601091916.k09JGMJY004116@hera.kernel.org>
	<20060110221313.GA24246@suse.de> <200601110034.58911.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200601110034.58911.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: fix large nvram access
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Jan 11, Arnd Bergmann wrote:

> Am Dienstag, 10. Januar 2006 23:13 schrieb Olaf Hering:
> >  On Mon, Jan 09, Linux Kernel Mailing List wrote:
> > > tree da8f883f72d08f9534e9eca3bba662413b9bd865
> > > parent d52771fce4e774fa786097d34412a057d487c697
> > > author Arnd Bergmann <arnd@arndb.de> Fri, 09 Dec 2005 19:21:44 +0100
> > > committer Paul Mackerras <paulus@samba.org> Mon, 09 Jan 2006 14:53:31
> > > +1100
> > >
> > > [PATCH] powerpc: fix large nvram access
> > >
> > > /dev/nvram uses the user-provided read/write size
> > > for kmalloc, which fails, if a large number is passed.
> > > This will always use a single page at most, which
> > > can be expected to succeed.
> > >
> > > Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
> > > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > >
> > >  arch/powerpc/kernel/nvram_64.c |  114
> > > +++++++++++++++++++----------------------
> >
> > this change breaks my nvsetenv binary on JS20.
> >
> 
> I think this has uncovered a bug that has been in nvsetenv for a long time.

Yeah. Dont bother, I will fix that tool.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
