Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080924194.11826.27.camel@thor.asgaard.local>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1080961566.1425.84.camel@gaston>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 13:06:06 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-03 at 02:43, Michel Dänzer wrote:
> On Fri, 2004-04-02 at 18:00, Michel Dänzer wrote:
> >
> > Note that the stuck processes only started with 2.6.5-rc3-ben0 here; the
> > last iteration of 2.6.5-rc2-ben0 is actually quite usable, albeit not
> > perfect either.
>
> I forgot to mention that the spurious segfaults also seemed much rarer
> with 2.6.5-rc2-ben0.

I see no reason for that. I just added more protection ;)

I also added a WARN_ON(), do you see it triggered in dmesg ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
