Date: Mon, 13 Aug 2001 08:15:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI IDE Adapter for PPC/Linux
Message-ID: <20010813081521.B9133@cpe-24-221-152-185.az.sprintbbd.net>
References: <200108130720.AAA03800@krakatoa.gigabitnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108130720.AAA03800@krakatoa.gigabitnetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 13, 2001 at 12:20:28AM -0700, James F Dougherty wrote:
>
> (LOL) .... I have the Promise Ultra-66..... since it's
> not working, this is what prompted me to look for an
> alternative ..
>
> I have ported MontaVista HHL (Linux 2.4.2) to
> a custom processor board, and have been
> trying to run fdisk to setup a mountable root
> drive.

Have you tried the card in another PPC?  Are you seeing any other
PCI related issues on your custom board?

> mousse-(17):[11:31pm]: [/>devfsd /dev
> Started device management daemon for /dev
> mousse-(18):[11:31pm]: [/>fdisk /dev/hda
> modprobe: Can't locate module /dev/hda
> modprobe: Can't locate module /dev/hda

That's odd.  Do you have /dev/ide/host0/bus0/target0/lun0/anything?
I _think_ you shouldn't see a modprobe error if the ide-disk driver is
installed already, I think.  But I'm not sure.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
