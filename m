Date: Tue, 26 Feb 2002 09:00:39 -0700
To: "marc. h." <heckmann@hbe.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: jdk 1.4?
Message-ID: <20020226160039.GA18735@dsdk12.net>
References: <15482.32063.537466.19280@esb.bbn.com> <20020225182235.D713@ukans.edu> <20020226021641.GC10864@shiva.marian> <20020226040351.GA26767@dsdk12.net> <20020226104929.GA7754@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020226104929.GA7754@hbe.ca>
From: dpates@dsdk12.net (Derrik Pates)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 26, 2002 at 11:49:30AM +0100, marc. h. wrote:
> lack of JIT hurts though. Have you ever tried the IBM j2SDK for PPC?. It's
> noticeably faster on my Powerbook G3. (you can download it from IBM, just
> google for it.) Problem is that the IBM jvm has been broken for me since kernel
> 2.4.16. 2.4.15-pre1 is the last know working kernel for me. On later kernels it
> just keeps calling sched_yield() endlessly and burns System CPU time. I'd like
> to fire off an email to IBM about the problem, but don't know exactly where to
> fire the email off to. I use the blackdown (whose excellent work I appreciate)
> release now as well.

I hadn't actually tried the IBM JVM for PPC - the only link I'd seen for
it pointed to some SuSE site. I am, however, running 2.4.17-benh0 on
this iBook, so I guess if you experience is correct, it wouldn't work on
here anyhow. Also, did it come with an OJI Java plugin for use with
Mozilla? (I'd bet not.)

> Is the blackdown release fast enough for you, or is there something I'm
> missing?

Well, I don't run too much Java stuff, so it's been sort of a non-issue.
I'm sure a JIT for the PPC would speed things up a lot, but the lack of
it hasn't been a real issue for me, for the most part.

--
Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
