Subject: Re: PREEMPT problems
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080867387.1203.19.camel@gaston>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080921611.11826.13.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Fri, 02 Apr 2004 18:00:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-02 at 02:56, Benjamin Herrenschmidt wrote:
> On Fri, 2004-04-02 at 00:32, Colin LEROY wrote:
> >
> > This won't be really helpful, as I have no time to investigate, but I seem
> > to have problems with preempt (and latest main-tree BK). After a few hours
> > of uptime, I get hanging processes (sed, cvs (can't be network related as
> > the CVSROOT is local)) and gcc segfaults while compiling kernel.

Same here, but at least some of the stuck processes continue after 'a
while'.

Note that the stuck processes only started with 2.6.5-rc3-ben0 here; the
last iteration of 2.6.5-rc2-ben0 is actually quite usable, albeit not
perfect either.

> Oh, btw, finding out where those are beeing stuck may help. A good
> way to do that is to use xmon "P" command, look at the KSP for one
> of those processes (kernel stack pointer) and do a backtrace based
> on it with "b <ksp value>"

How do I get into xmon again? Unfortunately, I didn't load the
System.map with this kernel...


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
