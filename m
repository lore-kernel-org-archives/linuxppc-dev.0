Date: Tue, 14 Aug 2001 14:03:30 +0100
Subject: Re: Occasional crash reports
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010814130302.0261BDB9FB@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 14, 2001, Takashi Oe wrote:
> On Tue, 14 Aug 2001, Iain Sandoe wrote:
>
>> > I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
>> > are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
>> > rather easily with regular programs, given a day or two.
>>
>> Can you point at which program reliably crashes beige/G3?
>
> It's usually rsync.

hmm.  don't use that as much - but it's consistent with network activity -
does it show up as an illegal instruction?

>> that's what I use as my dev/build machine and it seems to be stable (2.4.x)
>> except under the following circumstance:
>>
>> If I boot using the BootX application - at which point something drops a
>> bomb which almost always ends up in the network stack and shows up as an
>> illegal instruction (usually an FP one).
>
> Ah, yes, we use BootX app here, too.  Version 1.2.2, I think.

try a hard reboot and use the BootX init - that seems to cure the problem
for me.  Finding out what the problem actually is might be more tricky ;-)

I'm on 1.2.2 as well - so that's the same.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
