Subject: Re: jdk 1.4?
From: Ryan Boder <boder@cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020226160039.GA18735@dsdk12.net>
References: <15482.32063.537466.19280@esb.bbn.com>
	<20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian>
	<20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca>
	<20020226160039.GA18735@dsdk12.net>
Content-Type: text/plain
Date: 26 Feb 2002 11:12:15 -0500
Message-Id: <1014739935.4995.19.camel@TOBY>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-02-26 at 11:00, Derrik Pates wrote:
>
> On Tue, Feb 26, 2002 at 11:49:30AM +0100, marc. h. wrote:
> > lack of JIT hurts though. Have you ever tried the IBM j2SDK for PPC?. It's
> > noticeably faster on my Powerbook G3. (you can download it from IBM, just
> > google for it.) Problem is that the IBM jvm has been broken for me since kernel
> > 2.4.16. 2.4.15-pre1 is the last know working kernel for me. On later kernels it
> > just keeps calling sched_yield() endlessly and burns System CPU time. I'd like
> > to fire off an email to IBM about the problem, but don't know exactly where to
> > fire the email off to. I use the blackdown (whose excellent work I appreciate)
> > release now as well.

I had problems with the IBM java also. It worked great the first time
through (running Limewire) but, after that it would always tell me that
it couldn't allocate the needed memory are exit right away.

So I had to switch back to blackdown. I haven't run any actual tests or
anything, but the IBM one seemed faster (probably because it is JIT
enabled), but atleast the blackdown java works.

Ryan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
