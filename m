Date: Tue, 26 Feb 2002 17:06:16 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: jdk 1.4?
Message-ID: <20020226160614.GA8235@hbe.ca>
References: <15482.32063.537466.19280@esb.bbn.com> <20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian> <20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca> <20020226160039.GA18735@dsdk12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020226160039.GA18735@dsdk12.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, Feb 26, 2002 at 09:00:39AM -0700, Derrik Pates wrote:
> On Tue, Feb 26, 2002 at 11:49:30AM +0100, marc. h. wrote:
> > lack of JIT hurts though. Have you ever tried the IBM j2SDK for PPC?. It's
> > noticeably faster on my Powerbook G3. (you can download it from IBM, just
> > google for it.) Problem is that the IBM jvm has been broken for me since kernel
> > 2.4.16. 2.4.15-pre1 is the last know working kernel for me. On later kernels it
> > just keeps calling sched_yield() endlessly and burns System CPU time. I'd like
> > to fire off an email to IBM about the problem, but don't know exactly where to
> > fire the email off to. I use the blackdown (whose excellent work I appreciate)
> > release now as well.
>
> I hadn't actually tried the IBM JVM for PPC - the only link I'd seen for
> it pointed to some SuSE site. I am, however, running 2.4.17-benh0 on
> this iBook, so I guess if you experience is correct, it wouldn't work on
> here anyhow. Also, did it come with an OJI Java plugin for use with
> Mozilla? (I'd bet not.)

Would you mind giving it a shot? (or someone else?) I want to be sure that it's
not a local Glibc issue or such thing. I also haven't tried a recent benh
kernel..

you can download from: http://www6.software.ibm.com/dl/dklx130/dklx130-p

only annoying thing is that you have to register for a password.

-m

--
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
