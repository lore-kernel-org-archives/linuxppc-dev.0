Subject: Re: jdk 1.4?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: "marc. h." <heckmann@hbe.ca>
Cc: Derrik Pates <dpates@dsdk12.net>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020226160614.GA8235@hbe.ca>
References: <15482.32063.537466.19280@esb.bbn.com>
	<20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian>
	<20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca>
	<20020226160039.GA18735@dsdk12.net>  <20020226160614.GA8235@hbe.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 26 Feb 2002 17:19:57 +0100
Message-Id: <1014740397.870.1066.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Die, 2002-02-26 at 17:06, marc. h. wrote:
>
> On Tue, Feb 26, 2002 at 09:00:39AM -0700, Derrik Pates wrote:
> > On Tue, Feb 26, 2002 at 11:49:30AM +0100, marc. h. wrote:
> > > lack of JIT hurts though. Have you ever tried the IBM j2SDK for PPC?. It's
> > > noticeably faster on my Powerbook G3. (you can download it from IBM, just
> > > google for it.) Problem is that the IBM jvm has been broken for me since kernel
> > > 2.4.16. 2.4.15-pre1 is the last know working kernel for me. On later kernels it
> > > just keeps calling sched_yield() endlessly and burns System CPU time. I'd like
> > > to fire off an email to IBM about the problem, but don't know exactly where to
> > > fire the email off to. I use the blackdown (whose excellent work I appreciate)
> > > release now as well.
> >
> > I hadn't actually tried the IBM JVM for PPC - the only link I'd seen for
> > it pointed to some SuSE site. I am, however, running 2.4.17-benh0 on
> > this iBook, so I guess if you experience is correct, it wouldn't work on
> > here anyhow. Also, did it come with an OJI Java plugin for use with
> > Mozilla? (I'd bet not.)
>
> Would you mind giving it a shot? (or someone else?) I want to be sure that it's
> not a local Glibc issue or such thing. I also haven't tried a recent benh
> kernel..

Works here, but then I've applied a couple patches:
2.4.18-pre9-benh-o1-xfs-lolat-aa ;)

As you mention sched_yield(), the O(1) scheduler patch could make the
difference?


> you can download from: http://www6.software.ibm.com/dl/dklx130/dklx130-p
>
> only annoying thing is that you have to register for a password.

You can get it from the SuSE FTP server without that.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
