From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
Date: Wed, 16 Jun 2004 12:04:23 +0930
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>, cpufreq@www.linux.org.uk
References: <200406051846.50718.toojays@toojays.net> <200406102105.27654.toojays@toojays.net> <1086883926.2977.145.camel@gaston>
In-Reply-To: <1086883926.2977.145.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406161204.30453.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Fri, 11 Jun 2004 01:42 am, Benjamin Herrenschmidt wrote:
> > I have made a new patch for this, available from:
> > http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040610.patch
>
> Looks good except for some coding style issues ;)
>
> Use spaces between } and else for example, there's also an if without a
> space before the ( and please, name the low level asm function low_* like
> the other ones, for consistency.

A new patch which addresses these issues is at:
http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040616.patch

This is functionally identical to the previous patch.

cheers,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
