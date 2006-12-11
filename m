Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 61ADD67E8A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 05:33:17 +1100 (EST)
Date: Mon, 11 Dec 2006 21:33:26 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/6] [POWERPC] 8xx: powerpc port of core CPM, CPM PIC, etc.
Message-ID: <20061211213326.20f14f95@vitb.ru.mvista.com>
In-Reply-To: <20061211122041.21b1037d@pb15>
References: <20061211192347.47700906@localhost.localdomain>
	<20061211162848.17227.91021.stgit@localhost.localdomain>
	<20061211122041.21b1037d@pb15>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Dec 2006 12:20:41 -0600
Olof Johansson <olof@lixom.net> wrote:

> Hi,
> 
> On Mon, 11 Dec 2006 19:28:48 +0300 Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> 
> > This covers common CPM access functions, CPM interrupt controller code,
> > micropatch and a few compatibility things to kee the same driver base
> > working with arch/ppc. This version is refined with all the comments
> > (mostly PIC-related) addressed.
> > 
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
> > 
> >  arch/powerpc/sysdev/Makefile     |    2 
> >  arch/powerpc/sysdev/commproc.c   |  398 ++++++++++++++++++++
> >  arch/powerpc/sysdev/micropatch.c |  743 ++++++++++++++++++++++++++++++++++++++
> >  arch/powerpc/sysdev/mpc8xx_pic.c |  197 ++++++++++
> >  arch/powerpc/sysdev/mpc8xx_pic.h |   12 +
> >  include/asm-powerpc/fs_pd.h      |   44 ++
> >  include/asm-powerpc/mpc8xx.h     |   24 +
> >  include/asm-powerpc/time.h       |    2 
> >  8 files changed, 1412 insertions(+), 10 deletions(-)
> 
> Are these devices common for more platforms than 8xx? The 8xx in the
> filenames seems to indicate that they're not.
> 
More or less, this is a port from arch/ppc, and cpm2 stuff which is pretty much 
alike residing in sysdev. Maybe pic stuff should be renamed to cpm_pic, but IMO
the upper name is less confusing at the current point.

> If so, shouldn't the drivers go under platforms/8xx instead?
> 
Maybe, but not at the moment: for this code I'd like to keep coherency with arch/ppc
in case of something missed/ etc.

-- 
Sincerely, 
Vitaly
