Mime-Version: 1.0
Message-Id: <p04330100b629527c3036@[192.168.0.1]>
In-Reply-To: <19340928092828.1670@192.168.1.2>
References: <p04330100b627ff09296b@[192.168.0.1]>
 <19340928092828.1670@192.168.1.2>
Date: Sat, 4 Nov 2000 01:03:01 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre17?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >I am aware that this kernel is being worked on daily (that's why I
>>try to rebuild it each night), but I'm a little surprised that I am
>>having so much trouble with a pre17 kernel. Anybody know what's up?
>>Is this thing going through such big changes that I should let it go
>>for a while instead of trying each night?
>
>Well, first try with a more recent bootx.. that may help.


After a long evening of playing with this, I stand by my original assertion :-)

I did update to BootX 1.2.2, and started from scratch by playing with
several settings. I also scrounged several 2.2.18 versions, newly
rsynced from penguinppc.org::linux-pmac-stable and
ppc.linuxcare.com::linux-pmac-stable, and also earlier 2.2.18 rsyncs
that were stored on different computers available to me.

The two things that are constant on my hardware (PowerTowerPro +
PowerLogix G3, 6 PCI cards, most of which are not seen anyway,
2940UW):

1. Full boot is impossible, always with one of the following circumstances:
	a) freeze at "booting..."
	b) can't find MAC address for MACE device -> kernel panic
	c) "machine check in kernel mode" -> "unknown values in srr1" ->
		kernel panic

2. no video checkbox is ignored, on or off. There is no way to force
OFfb, regardless of kernel args or video checkboxes. The imstt card
is -always- found and the driver -always- loaded. Most odd, I've
never seen this one before.


Reverting to 2.2.17-linux-pmac-stable fixes everything. Looks to me
like 2.2.18-linux-pmac-stable is undergoing serious under-the-hood
changes, at least for my hardware. It makes me pretty nervous. I
don't think I have the expertise to sleuth this, I just wanted to
post to the list in case the info helped anyone.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
