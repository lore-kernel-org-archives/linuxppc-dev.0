Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id C149AB70D2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 11:58:50 +1000 (EST)
Subject: Re: Oops in trace_hardirqs_on (powerpc)
From: Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <20100927125037.GA4497@alea.gnuu.de>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
	<20100927125037.GA4497@alea.gnuu.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Sep 2010 21:58:14 -0400
Message-ID: <1285639094.2989.1.camel@frodo>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-09-27 at 14:50 +0200, Jörg Sommer wrote:
> Hello Steven,
> 
> Steven Rostedt hat am Wed 22. Sep, 15:44 (-0400) geschrieben:
> > Sorry for the late reply, but I was on vacation when you sent this, and
> > I missed it while going through email.
> > 
> > Do you still have this issue?
> 
> No. I've rebuild my kernel without TRACE_IRQFLAGS and the problem
> vanished, as expected. The problem is, that in some cases the stack is
> only two frames deep, which causes the macro CALLER_ADDR1 makes an
> invalid access. Someone told me, there a workaround for the problem on
> i386, too.
> 
> % sed -n 2p arch/x86/lib/thunk_32.S
>  * Trampoline to trace irqs off. (otherwise CALLER_ADDR1 might crash)

Yes, I remember that problem. When I get back from Tokyo, I'll tried to
remember to fix it.

Thanks!

-- Steve
