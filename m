Message-ID: <3C44A4AF.9000302@cray.com>
Date: Tue, 15 Jan 2002 15:52:47 -0600
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: a MINIMAL405 submodel
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings.

I have made a trivial little patch (and a few files..) to define a
"minimally configured" 405[gp] board.  Its basically a 405 with
no KB, RTC, PCI, et.al.  The idea being that if you define this
submodel of CONFIG_4xx then you write loadable modules on your own
to handle peripherals; this being just enough in the kernel to
get you to net- or flash-boot.

Its like a "WALNUT" but without any peripheral bank setup, RTC or
KB assumptions.. you get the idea.

In our case we bolt on lots of silly junk to the expansion banks
and do DMA... but all inside of custom little drivers that set those
banks up.  Might we be able to limit the proliferation of submodel
in the PPC 4xx world with the addition of my proposed MINIMAL405
submodel and then let vendors write drivers instead of kernels?

For any who care, have a peek at
	http://www.toimi.com/linuxppc
for the .patch file and a .tar file of needed additional platform
files.

Cheers.

--
Dave Updegraff / dave@cray.com / 218-525-1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
