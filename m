Message-Id: <200007051449.PAA31335@hyperion.valhalla.net>
Date: Wed, 05 Jul 2000 15:49:31 +0100
Subject: Re: GNU Parted, linuxppc support coming :-)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Andrew Clausen <clausen@gnu.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Clausen wrote:
> Hollis Blanchard wrote:
>> Andrew Clausen wrote:

>> > Note: I'm not adding HFS support at this stage - it's a LOT of work.
>> > So you'll be able to resize ext2 partitions in the near future, but
>> > not HFS partitions :-/  Unless there are some volunteers...
>>
>> There seems to be a shortage of HFS folks these days. :) But ext2
>> resizing sounds very cool.
>
> Excuse my ignorance... what FS's do people usually use with MacOS?
> HFS/HFS+?
>
> (Is the point "no-one uses MacOS", or "no-one's hacking on HFS
> in Linux"?)

People are still using a hybrid of both - this is because dual-boot machines
(e.g. all of mine) must use HFS if they want to talk to linux.

However, HFS is deprecated in the Mac world and is/will be replaced by HFS+
which includes the necessary support for MacOS X/Darwin and fits more
comfortably into the u*ix world (in general).

There is an Apple Paper on the issues
(http://www.mit.edu/people/wsanchez/papers/USENIX_2000/) which is quite
readable.

There are also some developers on the list who are actively working on HFS+
(I should be contributing, sorry guys, but am a bit tied up with audio stuff
right now).

We should keep HFS/HFS+ support - because there are still reasons to
dual/multi-boot Macs (e.g. Darwin work and some apps/stuff which just isn't
there on Linux... yet).

Hope that helps,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
