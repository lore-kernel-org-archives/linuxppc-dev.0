Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1081294118.2722.43.camel@thor.asgaard.local>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
	 <1080961566.1425.84.camel@gaston>
	 <1080997005.4208.24.camel@thor.asgaard.local>
	 <1081212676.1426.166.camel@gaston>
	 <1081294118.2722.43.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1081294401.1380.32.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Apr 2004 09:33:21 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> I'm back to a non-preempt kernel for the time being, but I'll try to do
> that if I ever feel adventurous again, and provided I find out how to
> get into xmon.

Command-power (if CONFIG_XMON is enabled of course).

"P" -> list of processes, may wrap around though, "P<pid>" (all numbers
are in hex in xmon) to see a specific one

"b" -> backtrace current, "b<ksp>" -> bactrace from the stack at <ksp>

"x" -> exit xmon (you may have a stuck cmd key, just press it until it
goes back to normal).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
