In-Reply-To: <38D7B56B.3E351682@ncal.verio.com>
Date: Tue, 21 Mar 2000 19:21:24 +0100
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Powerbook 2000 (Pismo) status.
Message-Id: <20000321192124.010641@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 21, 2000, Henry Worth <haworth@ncal.verio.com> wrote:

>> Like the iBook there is no power management yet, the new
>  PMU is undocumented and hasn't been reverse engineered. Ben's
>  iBook has a dead hard disk which is holding up his efforts,
>  though he seems to keep pretty busy on other projects...

yeah, not difficult to find things to do ;)

>> The LCD display is bright! There are no brightness or
>  contrast controls yet, the question that needs to be
>  researched is whether these are controlled by the PMU or
>  the Rage Mobility's power management facilities.

Well, I think it's the ATI chip. The device tree is full of

backlight-control = "ati"

stuffs and there's no backlight node under the PMU like there used to be
on other machines. I'll look at the docs, I hope it's not wired on the
GPIOs...

>> Sound??? Haven't tried, haven't even inquired as to the
>  iBook's status.

The device tree says it's an awacs/screamer on a davbus, like my G4, and
mine works. There is probably some trick to power it up since it's a
powerbook, but the chip itself is not the i2s stuff of the ibook for
which we don't know anything (yet). We just need to find out how to power
it up.

>> USB traps: some combinations of the keyboard and mouse I have
>  will work on one boot and cause a trap on the next (I think
>  the mouse, a Logitech 4-button scroller is causing the
>  driver's confusion).

Well, the USB stack we use is a backport of an old 2.3.x stack and may
still have problems. It works for me but I use only a MacAlly kbd and a
basic low cost 3 btn mouse.

>> PCMCIA/card slot: there is a new PCI bridge used that will
>  need support.

It's a TI1210, I think it's the same in the Lombard.


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
