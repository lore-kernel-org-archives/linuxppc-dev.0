From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
Date: Sat, 19 Jun 2004 12:49:31 +0930
Cc: Sebastian Henschel <linux@kodeaffe.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <200406051846.50718.toojays@toojays.net> <20040618120250.GA8657@fuchi> <1087572619.8207.275.camel@gaston>
In-Reply-To: <1087572619.8207.275.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406191250.18936.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Sat, 19 Jun 2004 01:00 am, Benjamin Herrenschmidt wrote:
> Can you produce a combined patch ?

Ben,

I've added the check for the 12" and 17" PBs to my patch, the latest version
is at http://www/~toojays/misc/7447a_cpufreq_20040619.patch. I haven't heard
from anybody using the 17" PB, but got the ID from
http://www.theapplemuseum.com/index.php?id=tam&page=products&subpage=newworld

Do you want the additions to pmac_mb_defs to go in the same patch? In my mind
the two issues are independent.

cheers,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
