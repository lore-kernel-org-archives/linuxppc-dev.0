Date: Fri, 6 Dec 2002 11:52:06 -0700
From: Matt Porter <porter@cox.net>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Matt Porter <porter@cox.net>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021206115206.C18257@home.com>
References: <20021206113007.B18257@home.com> <IGEFJKJNHJDCBKALBJLLOEJHFIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEJHFIAA.joakim.tjernlund@lumentis.se>; from joakim.tjernlund@lumentis.se on Fri, Dec 06, 2002 at 07:15:15PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 06, 2002 at 07:15:15PM +0100, Joakim Tjernlund wrote:
> >
> > On Fri, Dec 06, 2002 at 05:08:22PM +0100, Joakim Tjernlund wrote:
> > that's a problem with m8xx_cpm_hostalloc() (or how you are using it) if
> > it doesn't keep around the values you need.
> >
>
> Yes and no, someone changed the m8xx_cpm_hostalloc() implementation and now
> it does not behave as it used to. Earlier both __pa(adr) and __va(__pa(adr))
> worked on addresses returned by m8xx_cpm_hostalloc().
>
> I think in it's current form it's useless and should either be changed back to what
> it was or die.

The 8xx-specific stuff is clearly Dan's area...I was just commenting
on your generic concerns about consistent_*.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
