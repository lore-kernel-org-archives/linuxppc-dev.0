Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DFB11DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 09:27:29 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 04 Feb 2008 23:20:47 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20080204104232.GB29484@csn.ul.ie>
Message-ID: <20080204222047.243670@gmx.net>
MIME-Version: 1.0
References: <20080201184254.174020@gmx.net> <20080201191119.GI18688@csn.ul.ie>
	<20080201200518.174050@gmx.net> <20080201202518.GJ18688@csn.ul.ie>
	<20080201210656.174030@gmx.net> <20080204104232.GB29484@csn.ul.ie>
Subject: Re: Commit for mm/page_alloc.c breaks boot process on my machine
To: Mel Gorman <mel@csn.ul.ie>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 4 Feb 2008 10:42:32 +0000
> Von: Mel Gorman <mel@csn.ul.ie>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
> Betreff: Re: Commit for mm/page_alloc.c breaks boot process on my machine

> > > > > 2. Any chance of seeing a dmesg log?
> > > > That's a little bit of a problem. The kernel log in memory doesn't
> > > > show any kernel oops, but is also fragmented (small fragments seem
> > > > to have been overwritten with 0x0).
> > > 
> > > err, that doesn't sound very healthy.
> >
> > Yeah, I know. But the platform code hasn't changed much when porting it
> > from arch/ppc to arch/powerpc. That's why I'm a little bit lost in this
> > case. :-)
> > 
> 
> I'm at a bit of a loss to guess what might have changed in powerpc code
> that would explain this. I've added the linuxppc-dev mailing list in
> case they can make a guess.
Yes, I'll try to get some comments on the linuxppc-dev mailing list.

> I think you are also going to need to start bisecting searching
> specifically for the patch that causes these overwrites.
I think I had a similar problem with kernel v2.6.23, too and therefore
waited for kernel 2.6.24. So the problem may exist since a long time.

> It's a virtual address so it depends on the value of CONFIG_KERNEL_START
> as to whether this is a user program address or not.
AFAIK start_kernel() is called very early in the boot process, were no
user or kernel thread is active. I also wonder why the kernel crashes when
the mem boot option is used. Let's see what the linuxppc-dev people say.

Thanks for your help!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
