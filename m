From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jonas Smedegaard <js@debian.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <debian@jones.dk>
Subject: Re: [Debian] Irda can work
Date: Wed, 31 Oct 2001 17:03:13 +0100
Message-Id: <20011031160313.7048@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0110311636080.10961-100000@auryn.jones.dk>
References: <Pine.LNX.4.33.0110311636080.10961-100000@auryn.jones.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> On Wed, Oct 31, 2001 at 03:24:31PM +0100, Jonas Smedegaard wrote:
>> > and btw: I recommend kernel from BenH from 30/10 - it runs flawlessly on
>> > my machine, and has ide performance optimizations it seems (but
don't know
>> > if it is TiBook related though)
>>
>> We have some problems with DMA on BenH's kernel from yesterday
(30.10.2001),
>> (maybe we've got it later).
>>
>> Same problem with as described in
>> http://lists.linuxppc.org/linuxppc-dev/200110/msg00371.html
>>
>> Anybody know what is causing this problem or how to get an older,
>> but more stable BenH tree without it?

I rewrote the IDE timing code a few days ago, and well... it wasn't
completely bug free ;) Well, it should be ok now, the timings put
into the controller are the same as Darwin and MacOS 9 use for
a given disk, except for some older machines (OHare based) where
I suspect some HW problems and so limited the MDMA cycle time to
150ns (which is approx MDMA1).

Except from that, my kernel got no major change lately, only small
fixes here or there.

Note that you should probably post diffs against _2_4_devel, they
would be a lot smaller :) My tree is a "child" of _devel and
my changes are regulary pushed upstream.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
