From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Sat, 5 Aug 2000 13:25:31 +0200
Message-Id: <20000805112531.1840@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000804195419.649B-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000804195419.649B-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>As Geert has pointed out, hwclock can give UTC or local time to /dev/rtc,
>why don't we just let userland deal with this local time issue.  What I
>mean is for pmac_set_rtc_time(), let's change:

That would give us back what we had at the beginning. This way, userland
is solely responsible for this setup, which means it will be wrong on 50%
of user machines (but that's user fault isn't it ?) and which means the
kernel will boot with a wrong time, at least until the userland init
script takes over.

I don't see why it's such a mess to simply read the default values from
xpram so we are consistent with MacOS. But everything in Linux is a mess
anyway...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
