Subject: Re: PREEMPT problems
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080961566.1425.84.camel@gaston>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
	 <1080961566.1425.84.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080997005.4208.24.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 14:56:45 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-03 at 05:06, Benjamin Herrenschmidt wrote:
> On Sat, 2004-04-03 at 02:43, Michel Dänzer wrote:
> > On Fri, 2004-04-02 at 18:00, Michel Dänzer wrote:
> > >
> > > Note that the stuck processes only started with 2.6.5-rc3-ben0 here; the
> > > last iteration of 2.6.5-rc2-ben0 is actually quite usable, albeit not
> > > perfect either.
> >
> > I forgot to mention that the spurious segfaults also seemed much rarer
> > with 2.6.5-rc2-ben0.
>
> I see no reason for that. I just added more protection ;)

Sure enough, -rc2-ben0 is now behaving just as badly as -rc3-ben0.
Probably just fluctuation.

> I also added a WARN_ON(), do you see it triggered in dmesg ?

I'm not sure what those would look like, but

zgrep -i warn /var/log/kern.log*

doesn't seem to yield anything relevant.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
