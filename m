Subject: Re: Again with the firewire
From: Stefan Piger <piger@rvs.uni-hannover.de>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset=ISO-8859-15
Date: 22 Nov 2001 08:15:02 +0100
Message-Id: <1006413308.947.0.camel@grobi>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ask Apple what they did ... their chipset isn't documented and they
> didn't opensource their firewire driver for it.
>
> Note that working firewire for pismo/tipb exist in my rsync tree
> or in the linux1394 CVS. Linus and bk _devel aren't up-to-date yet.
>
> Ben.

I can't get firewire to work with your rsync tree on my Pismo (at least
with no one up to yesterday). When I load the modules all looks ok (to
me):

Nov 22 07:23:06 localhost kernel: ohci1394: $Revision: 1.79 $ Ben
Collins <bcollins@debian.org>
Nov 22 07:23:06 localhost kernel: ohci1394_0: OHCI-1394 1.0 (PCI):
IRQ=[40]  MMIO=[f5000000-f5001000]  Max Packet=[2048]
Nov 22 07:23:06 localhost kernel: ieee1394: sbp2: Driver forced to
serialize I/O (serialize_io = 1)
Nov 22 07:23:06 localhost kernel: scsi1 : IEEE-1394 SBP-2 protocol
driver

After loading the modules, there is no /proc/ohci1394 as I remember from
earllier versions of linux1394.
When I plug in a firewire device the keyboard becomes unusable, but the
machine doesn't crash, I can reboot it via ssh.
I get no error messages in /var/log/messages.

Do you have any idea why it doesn't work? I tried the same on a friends
Pismo an had the same effects!

regards, Stefan

--
Dipl.-Ing. Stefan Piger
Lehrgebiet Rechnernetze und Verteilte Systeme
Universität Hannover
Tel. 0511-762-79-4726
Fax 0511-762-3003


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
