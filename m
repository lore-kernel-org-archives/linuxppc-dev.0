Date: Thu, 20 May 1999 13:12:07 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Satadru Pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc hardware clock.
In-Reply-To: <Pine.LNX.4.10.9905201029580.7786-100000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.4.05.9905201310450.746-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 May 1999, Satadru Pramanik wrote:

> I did a rebuild and install of many redhat 6.0 src rpms before the ppc
> equivalent came out.  As a result, i have a program called "hwclock" in my
> rc scripts that refuses to be able to get the date from the hardware
> clock.  I think this program may be specific to x86 platforms.  Which new
> ppc.rpm should I upgrade to to fix this?  which program in particular will
> access the clock on a apple 7600 correctly on a glibc2.1 system?

hwclock doesn't work on PMacs.  It's for machines w/ a PC type rtc.  Get
the pmac-utils srpm (or RR1.0 rpm) and use clock.  You might also wanna
look at the RR1.0 util-linux rpm. (Just to get rid of the hwclock stuff)

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
