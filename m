From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Thu, 10 Aug 2000 01:48:57 +0200
Message-Id: <20000809234857.16035@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000809180837.866H-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000809180837.866H-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Saving the timezone value to xpram is another issue. It could be done
>> from userland but we currently don't have userland tool that properly
>> access the xpram portion of the nvram. I did plan to add some ioctls to /
>> dev/nvram for it to return the location of the various nvram partitions,
>> looks like it will be time to actually implement them... Also, the
>> userland tool will have to be written...
>
>I had a xpram manipulation tool, so I modified it a bit.  Also, I added an
>ioctl to drivers/macintosh/nvram.c.
>
>Please have a look at them.  Are these what you had in mind?

Ah, sometimes I'd like to have more often access to my linux boxes ;)

Looks nice, I'll test that asap (probably sometimes this week-end) and
push along with the other fixes.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
