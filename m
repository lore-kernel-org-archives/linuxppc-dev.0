Date: Sun, 25 Feb 2001 02:43:50 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Thomas Graichen <thomas.graichen@innominate.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc initrd problem?
In-Reply-To: <news2mail-97ag1d$52i$3@mate.bln.innominate.de>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010225024100.85078A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 25 Feb 2001, Thomas Graichen wrote:

[...]
> thanks a lot - btw. also tried it with 16M - same thing - compressed
> initrd image hangs and an uncompressed loads but seems to have only
> trash in it ("cannot find init" while /sbin/init is definitely in it)

You may want to make the ramdisk under 2.2.x kernel or 2.4.2+loop fixes.
I've seen some loop device problem reports in linux-kernel, and it could
be contributing to your problem.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
