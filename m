Date: Tue, 28 Oct 2003 15:25:19 -0800
From: mutex <mutex@kerneli.org>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Video mirroring with radeon mobility 9600
Message-ID: <20031028232518.GD25007@heliosphan.futuretel.com>
Reply-To: mutex <mutex@kerneli.org>
References: <6EA3E629-099A-11D8-B1A5-000393467F1A@arlut.utexas.edu>
Mime-Version: 1.0
In-Reply-To: <6EA3E629-099A-11D8-B1A5-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 28, 2003 at 04:59:49PM -0600 or thereabouts, Ken Offer wrote:
>
> Anyone out there had any luck getting video mirroring to work on the
> 2003 15" PowerBook?

i have a 9000 and i have gotten mirroring working in X only.  BenH can
respond more in depth... but what I have found is that you:

1) plug in the external video
2) modify X config to have an alternate resolution, that is what is
required by the external source
3) start X with modified X config, and it 'just works'

this worked for me.. i can post my config file somewhere if you like.

> My modified 2.4 kernel won't mirror.
> I've tried the latest radeon driver from the 2.6 kernel and I can't get
> it to work either.
>
> The yaconf boot parameters I used under the 2.6 were:
>
> 	append="hdc=ide-scsi video=radeonfb:dfp,mirror"

my experience is that the mirror option just plain doesn't work.

> I hooked up a flat-screen monitor to the laptop via a digital-to-vga
> cable.  When mirroring is suppose to come on, I get something which
> looks like Open-Firmware text on the other monitor.
>
> I've tried modifying m3mirror to access the radeon driver.  It appears
> to turn the lcd and crt displays on and off, but it still doesn't
> mirror.  I'm still stuck with the OpenFirmware display.

iirc m3mirror is for r128 chips.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
