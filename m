Date: Thu, 6 Jul 2000 07:38:01 -0700 (PDT)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-boot advice.
In-Reply-To: <200007052323.AAA07099@hyperion.valhalla.net>
Message-ID: <Pine.GSO.4.21.0007060724510.17224-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 Jul 2000, Iain Sandoe wrote:

> I've just got a G4/500 - and I want to configure it to boot:
>
> LinuxPPC.
> MacOS (9)
> MacOS (X) / Darwin
>
> Does anyone know if there is one boot method that will do all three?

Yes. New-world machines like yours have a built-in graphical multibooter.
Hold down option during boot, and you get a button for each bootable
volume found by open firmware. For this to work with Linux, you must be
using an OF-bootable partition with yaboot, such as the one set up by ybin
<http://www.alaska.net/~erbenson/ybin/>. In the latest version, there's
even a cute penguin icon for the yaboot button.

This method is somewhat slow, and you *must* hold down option to boot into
any OS other than your default. Because I rarely boot out of Linux,
however, I use it on my iMac 350 to tri-boot with MacOS 9 and Darwin.

I believe this should work on the iBook, AGP G4, slot-loading iMacs, and
Firewire PowerBooks. Can anyone verify or correct this?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
