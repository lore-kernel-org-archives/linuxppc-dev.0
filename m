Date: Mon, 13 Aug 2001 13:50:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: mlocke@mvista.com, dmj+@andrew.cmu.edu,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI IDE Adapter for PPC/Linux
Message-ID: <20010813135020.A10850@cpe-24-221-152-185.az.sprintbbd.net>
References: <200108132007.NAA04723@krakatoa.gigabitnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108132007.NAA04723@krakatoa.gigabitnetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 13, 2001 at 01:07:50PM -0700, James F Dougherty wrote:

> What else should I look at? Also, assuming this is a brand new
> drive (without any partitions on it), should I boot the disk under
> DOS and run fdisk to set up an initial MBR?

Linux can do it fine.  The problem is linux isn't seeing the drive
because the controller isn't working.

> Also, how come it is not running in Native mode? Does anyone know what
> the changes are to the pdc driver to enable this?

iirc, that means the BIOS didn't set it up, thats all.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
