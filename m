From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <thomas.graichen@innominate.com>
Subject: Re: ppc initrd problem?
Date: 25 Feb 2001 09:06:22 GMT
Message-ID: <news2mail-97ahue$qt6$1@mate.bln.innominate.de>
References: <news2mail-97ag1d$52i$3@mate.bln.innominate.de> <Pine.A41.3.96LJ1.1b7.1010225024100.85078A-100000@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe <toe@unlserve.unl.edu> wrote:

> On 25 Feb 2001, Thomas Graichen wrote:

> [...]
>> thanks a lot - btw. also tried it with 16M - same thing - compressed
>> initrd image hangs and an uncompressed loads but seems to have only
>> trash in it ("cannot find init" while /sbin/init is definitely in it)

> You may want to make the ramdisk under 2.2.x kernel or 2.4.2+loop fixes.
> I've seen some loop device problem reports in linux-kernel, and it could
> be contributing to your problem.

i know - but i tested the images on a normal running system both
via loopback mount and via dd to ramdisk and mount of it - both
were perfectly fine - also an fsck -f of the image file is com-
pletely ok

i did some more trying now: it seems to work with 16M (maybe with more
too) if the image is only lightly loaded - but if i fill the 16M
more it hangs at boot with

  RAMDISK: Compressed image found at block 0

t

p.s.: this is yaboot 0.8.SuSE btw.

--
thomas.graichen@innominate.com
                                                         innominate AG
                                                  the linux architects
tel: +49-30-308806-13   fax: -77             http://www.innominate.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
