Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>, cpufreq@www.linux.org.uk
In-Reply-To: <200406102105.27654.toojays@toojays.net>
References: <200406051846.50718.toojays@toojays.net>
	 <1086452473.12664.36.camel@gaston> <200406102105.27654.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1086883926.2977.145.camel@gaston>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 11:12:07 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have made a new patch for this, available from:
> http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040610.patch

Looks good except for some coding style issues ;)

Use spaces between } and else for example, there's also an if without a
space before the ( and please, name the low level asm function low_* like
the other ones, for consistency.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
