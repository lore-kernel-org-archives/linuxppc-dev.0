Date: Wed, 7 May 2003 02:52:06 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: What kind of Linux address must I use to set the SAR reg. of the DMA ctrl ?
Message-ID: <3EC0E6EE@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I am writing the code to start a DMA transfer with the built-in DMA controller
of the MPC8245. The purpose is to do Memory to PCI transfers. The PCI part
seems to be OK ( memory of the device is written) the the source address seems
to be wrong since I read 0XFFFFFFFF as data in the device. I tried with bus
and physical address (using virt_to_bus & virt_to_phys functions) but this
doesn't give good results.
So I ask myself which kind of linux address must I use to configure the SAR
register of the Dual channel DMA controller ?

If It works I will post a patch of my work.

Thanks

------------------------------------------------------------------------------
----
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
