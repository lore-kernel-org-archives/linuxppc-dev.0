Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: Sebastian Henschel <linux@kodeaffe.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200406191250.18936.toojays@toojays.net>
References: <200406051846.50718.toojays@toojays.net>
	 <20040618120250.GA8657@fuchi> <1087572619.8207.275.camel@gaston>
	 <200406191250.18936.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1087619961.9046.301.camel@gaston>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 23:39:22 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-06-18 at 22:19, John Steele Scott wrote:
>
> On Sat, 19 Jun 2004 01:00 am, Benjamin Herrenschmidt wrote:
> > Can you produce a combined patch ?
>
> Ben,
>
> I've added the check for the 12" and 17" PBs to my patch, the latest version
> is at http://www/~toojays/misc/7447a_cpufreq_20040619.patch. I haven't heard
> from anybody using the 17" PB, but got the ID from
> http://www.theapplemuseum.com/index.php?id=tam&page=products&subpage=newworld
>
> Do you want the additions to pmac_mb_defs to go in the same patch? In my mind
> the two issues are independent.

Hi ! Thanks. Yes, the mb defs can go into the same patch, I'll just
label it "improve support for newer powerbooks" ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
