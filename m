Date: Mon, 16 Apr 2001 12:59:03 +0100
Subject: Re: boot params
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010416115854.9A1722F09A@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 16, 2001, Ethan Benson wrote:
> On Mon, Apr 16, 2001 at 12:38:17PM +0100, Iain Sandoe wrote:
>> > Ethan Benson wrote:
>> >> the kernel HFS driver is unreliable.
>>
>> Hmmm.  What do you mean?  I use it a lot (without problems AFAICT) - is
>> there something I should know?
>
> apparently people get occasional filesystem corruption when copying
> larger files around.  its always been rather shady since nobody really
> gives a damn about it.

Those of us with OW machines - booting with BootX (and a vestigial need to
use MacOS for 'rent-paying-work' ;-) _do_ give a damn.  I'd be interested if
someone could point at a reliable way to replicate a fault.

> which is why something as important as the
> kernels should not live on HFS.

OW machines don't have the choice.

>  and bootloaders should live on a
> never mounted tiny HFS partition managed by hfsutils or preferably
> ybin.

...

> it comes up on irc here and there.

Yes, but I've not seen a report for months - the last IIRC were for 2.3.xx
kernels ...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
