Date: Fri, 4 Apr 2003 14:11:42 -0700
From: Matt Porter <porter@cox.net>
To: luca gambazzi <luca.gambazzi@epfl.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
Message-ID: <20030404141142.A5701@home.com>
References: <1048949739.5125.126.camel@shampoo.epfl.ch> <20030329154326.GE5343@ip68-0-152-218.tc.ph.cox.net> <1049456953.14675.53.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1049456953.14675.53.camel@shampoo.epfl.ch>; from luca.gambazzi@epfl.ch on Fri, Apr 04, 2003 at 01:49:13PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 04, 2003 at 01:49:13PM +0200, luca gambazzi wrote:
>
> Hi
>
> i'm still trying to bild a running linux kernel for a Force Computers
> CPCI-3750.
>
> I've got one more error, the ethernet card doesn't work.
> is a Digital DS21143 Tulip
>
> i've installed the kernel drivers (i've tried with 2.4 and 2.5
> penguinppc kernel tree), and the drivers found in
> http://sourceforge.net/projects/tulip, but the error is always the same.
>
> NETDEV WATCHDOG: eth0: transmit timed out

Assuming you are booting with the pcore kernel, are you sure that
the pci interrupt routing for the 3750 is identical to the 6750?

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
