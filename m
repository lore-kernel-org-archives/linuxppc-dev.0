Date: Tue, 26 Feb 2002 11:49:30 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Derrik Pates <dpates@dsdk12.net>
Cc: Steven Hanley <sjh@wibble.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: jdk 1.4?
Message-ID: <20020226104929.GA7754@hbe.ca>
References: <15482.32063.537466.19280@esb.bbn.com> <20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian> <20020226040351.GA26767@dsdk12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020226040351.GA26767@dsdk12.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 25, 2002 at 09:03:51PM -0700, Derrik Pates wrote:
>
> On Tue, Feb 26, 2002 at 01:16:42PM +1100, Steven Hanley wrote:
> > > I'd love to be able to use recent mozilla's with java.
> >
> > -rw-rw-r--    1 sjh      sjh      21398886 Jan 29 12:49 j2sdk-1.3.1-02a-FCS-linux-ppc.bin
> >
> > downloaded from a blackdown mirror that was up to date, this was released mid
> > january or so AFAIR.
>
> I've got it also (on an iBook FireWire) and it works great. I just wish
> that the Blackdown guys would release PPC debs of it too, instead of
> just for i386.

lack of JIT hurts though. Have you ever tried the IBM j2SDK for PPC?. It's
noticeably faster on my Powerbook G3. (you can download it from IBM, just
google for it.) Problem is that the IBM jvm has been broken for me since kernel
2.4.16. 2.4.15-pre1 is the last know working kernel for me. On later kernels it
just keeps calling sched_yield() endlessly and burns System CPU time. I'd like
to fire off an email to IBM about the problem, but don't know exactly where to
fire the email off to. I use the blackdown (whose excellent work I appreciate)
release now as well.

Is the blackdown release fast enough for you, or is there something I'm
missing?

Cheers,

-m


--
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
