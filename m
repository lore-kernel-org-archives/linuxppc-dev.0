Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080997005.4208.24.camel@thor.asgaard.local>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
	 <1080961566.1425.84.camel@gaston>
	 <1080997005.4208.24.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1081045248.1201.98.camel@gaston>
Mime-Version: 1.0
Date: Sun, 04 Apr 2004 12:20:48 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I also added a WARN_ON(), do you see it triggered in dmesg ?
>
> I'm not sure what those would look like, but
>
> zgrep -i warn /var/log/kern.log*
>
> doesn't seem to yield anything relevant.

They look like bactraces ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
