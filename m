Subject: Re: jdk 1.4?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: "marc. h." <heckmann@hbe.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020228131151.GD2183@hbe.ca>
References: <15482.32063.537466.19280@esb.bbn.com>
	<20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian>
	<20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca>
	<20020226160039.GA18735@dsdk12.net> <20020226160614.GA8235@hbe.ca>
	<1014740397.870.1066.camel@tibook>  <20020228131151.GD2183@hbe.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 28 Feb 2002 21:43:03 +0100
Message-Id: <1014928983.828.2992.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Don, 2002-02-28 at 14:11, marc. h. wrote:
> On Tue, Feb 26, 2002 at 05:19:57PM +0100, Michel D?nzer wrote:
> > > > I hadn't actually tried the IBM JVM for PPC - the only link I'd seen for
> > > > it pointed to some SuSE site. I am, however, running 2.4.17-benh0 on
> > > > this iBook, so I guess if you experience is correct, it wouldn't work on
> > > > here anyhow. Also, did it come with an OJI Java plugin for use with
> > > > Mozilla? (I'd bet not.)
> > >
> > > Would you mind giving it a shot? (or someone else?) I want to be sure that it's
> > > not a local Glibc issue or such thing. I also haven't tried a recent benh
> > > kernel..
> >
> > Works here, but then I've applied a couple patches:
> > 2.4.18-pre9-benh-o1-xfs-lolat-aa ;)
> >
> > As you mention sched_yield(), the O(1) scheduler patch could make the
> > difference?
>
> hmm, I tried the O(1) scheduler with your patch and it still doesn't work.
>
> maybe it's lolat? or benh? I'll try that tonight.
>
> but could you do me a favour? can you try out 2.4.18-rc4 vanilla? and confirm
> that it doesn't work? that would eliminate the possiblity that it's a userspace
> issue (or rather some kind of kernel-userspace interaction problem)

Why don't you just try Debian instead? ;)

Seriously, I can't test vanilla because my filesystems are all XFS. :)
And it's not that I have too much time, if you know what I mean... I
hope you understand and that your own testing will give some results.


> and you're sure your trying the IBM-jdk right? could be that you have the
> blackdown JDK installed as well and it comes first in your PATH or something?

I do have the Blackdown 1.1 and 1.3 JDKs installed as well, but I used
the absolute path to the IBM java executable for testing. Coult it still
have picked up some wrong libraries or something?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
