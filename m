Date: Thu, 28 Feb 2002 14:11:53 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: jdk 1.4?
Message-ID: <20020228131151.GD2183@hbe.ca>
References: <15482.32063.537466.19280@esb.bbn.com> <20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian> <20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca> <20020226160039.GA18735@dsdk12.net> <20020226160614.GA8235@hbe.ca> <1014740397.870.1066.camel@tibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1014740397.870.1066.camel@tibook>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 26, 2002 at 05:19:57PM +0100, Michel D?nzer wrote:
> > > I hadn't actually tried the IBM JVM for PPC - the only link I'd seen for
> > > it pointed to some SuSE site. I am, however, running 2.4.17-benh0 on
> > > this iBook, so I guess if you experience is correct, it wouldn't work on
> > > here anyhow. Also, did it come with an OJI Java plugin for use with
> > > Mozilla? (I'd bet not.)
> >
> > Would you mind giving it a shot? (or someone else?) I want to be sure that it's
> > not a local Glibc issue or such thing. I also haven't tried a recent benh
> > kernel..
>
> Works here, but then I've applied a couple patches:
> 2.4.18-pre9-benh-o1-xfs-lolat-aa ;)
>
> As you mention sched_yield(), the O(1) scheduler patch could make the
> difference?

hmm, I tried the O(1) scheduler with your patch and it still doesn't work.

maybe it's lolat? or benh? I'll try that tonight.

but could you do me a favour? can you try out 2.4.18-rc4 vanilla? and confirm
that it doesn't work? that would eliminate the possiblity that it's a userspace
issue (or rather some kind of kernel-userspace interaction problem)

and you're sure your trying the IBM-jdk right? could be that you have the
blackdown JDK installed as well and it comes first in your PATH or something?
just want to make sure.

thanks in advance.

-m

--
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
