Return-Path: <bwarren@qstreams.com>
Received: from web306.biz.mail.mud.yahoo.com (web306.biz.mail.mud.yahoo.com
	[68.142.199.182]) by ozlabs.org (Postfix) with SMTP id 77B66DE0AE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 10:10:40 +1000 (EST)
Date: Thu, 26 Apr 2007 17:10:39 -0700 (PDT)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: POSIX semaphores on ppc_6xx
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200704211733.13354.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <212894.34907.qm@web306.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Arnd,


--- Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 20 April 2007, Ben Warren wrote:
> > The cross-compiled glibc that is included in ELDK 4.0 doesn't seem to
> > have support for POSIX semaphores.  I get the following runtime errors:
> > 
> >    sem_open: Function not implemented
> > 
> > when trying to implement a named semaphore, and 
> > 
> >    sem_init: Function not implemented
> > 
> > when trying to implement an unnamed semaphore.
> > 
> > Does anybody know if POSIX semaphores have been ported to ppc_6xx, and
> > if so, where I could find a binary copy?
> 
> This normally works in every modern glibc. Maybe you were using an
> set of kernel headers that is too old. Make sure that you have
> up-to-date version of both kernel and glibc and that you use the
> kernel header files you get from 'make headers_install' in the kernel.
> 
> 	Arnd <><
> 

I haven't had a chance to try this out yet, but appreciate your tip!

regards,
Ben
