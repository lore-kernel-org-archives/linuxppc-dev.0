From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
Date: Sun, 20 Jun 2004 20:43:27 +0930
Cc: Sebastian Henschel <linux@kodeaffe.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <200406051846.50718.toojays@toojays.net> <200406191250.18936.toojays@toojays.net> <1087619961.9046.301.camel@gaston>
In-Reply-To: <1087619961.9046.301.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406202044.01554.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Sorry, I mailed this yesterday but forgot to Re:All so it didn't get to the
list.

On Sat, 19 Jun 2004 02:09 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2004-06-18 at 22:19, John Steele Scott wrot
> > Do you want the additions to pmac_mb_defs to go in the same patch? In my
> > mind the two issues are independent.
>
> Hi ! Thanks. Yes, the mb defs can go into the same patch, I'll just
> label it "improve support for newer powerbooks" ;)

Okay, here it is:
http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040619a.patch

What is it that is "unknown" about these boards, that they are called
PMAC_TYPE_UNKNOWN_INTREPID? There is no such thing as a "known" intrepid?

Also, I sent an email to the list asking about sleep a couple of days ago. Can
you comment on that?

cheers,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
