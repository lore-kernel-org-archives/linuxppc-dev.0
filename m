Return-Path: <jdl@jdl.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Fri, 23 Sep 2005 11:08:09 +0200."
	<20050923090809.GA31688@lst.de>
References: <E1EIVg5-0001HI-E8@jdl.com> <20050922183126.GA18853@lst.de>
	<E1EIVwC-0001IQ-5s@jdl.com> <20050923090809.GA31688@lst.de>
Date: Fri, 23 Sep 2005 07:54:52 -0500
Message-Id: <E1EIn4m-0001po-Bx@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH powerpc Merge asm-ppc*/seccomp.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Christoph Hellwig mumbled:
> > 
> > But keep the #include?  It's actually the part
> > that is defining TIF_32BIT for ppc64 (indirectly
> > through linux/thread_info.h and asm/thread_info.h).
> > Won't those bits be needed still?
> 
> I'm not sure.  This header definitly doesn't need it, but I suspect
> seccompt.c expects to get it via this header.

I dug around in this a bit.  The nested includes here yield
a fairly wide distribution of availability of TIF_32BIT.
I'm hesitant to remove it in this "merge" patch, so I
will leave its removal to a follow on patch/effort.

New patch with #if test removed coming up.

jdl
