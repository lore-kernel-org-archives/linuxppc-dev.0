Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: Sebastian Henschel <linux@kodeaffe.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200406202044.01554.toojays@toojays.net>
References: <200406051846.50718.toojays@toojays.net>
	 <200406191250.18936.toojays@toojays.net> <1087619961.9046.301.camel@gaston>
	 <200406202044.01554.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1087749240.22686.2.camel@gaston>
Mime-Version: 1.0
Date: Sun, 20 Jun 2004 11:34:02 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-06-20 at 06:13, John Steele Scott wrote:
>
> Okay, here it is:
> http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040619a.patch
>
> What is it that is "unknown" about these boards, that they are called
> PMAC_TYPE_UNKNOWN_INTREPID? There is no such thing as a "known" intrepid?

Bad naming of the constant, I should have called it "GENERIC_INTREPID"
instead. I used to define constants for machine models, but that ended
up being useless for newworld (still useful to differenciate some
oldworld though). So I just use the generic constant nowadays.

> Also, I sent an email to the list asking about sleep a couple of days ago. Can
> you comment on that?

The problem with sleep at this point is to wake up the video chip which
is shut down by the hardware. ATI will maybe provide infos for that one
day... Or I'll be able to reverse engineer enough when I find time...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
