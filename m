Date: Thu, 12 Oct 2000 11:14:54 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.4 kernel doesn't allocate resource for my PCI Board 
Message-ID: <Pine.LNX.4.21.0010121107090.10161-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm new to this list. I'm working on a VME Board from motorolla
(MVME2303) and I have a 2.2.17 kernel running without problem.

The board have a Pci Mezzanine Card with a NCR 53c895 chip for my SCSI
disk. When I try to boot the latest kernel (I'm trying from 2.4.0-test6 up
to 2.4.0-test10) I have the following error message during boot :

PCI: Cannot allocate resource region 1 of device 00:11.0
PCI: Cannot allocate resource region 2 of device 00:11.0
PCI: Failed to allocate resource 2 for Symbios Logic Inc. (formerly
NCR) 53c895

which leads to the following :
sym53c895-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Inquiry 00 00 00 ff 00
sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=1
serial_number_at_timeout=1
sym53c895-0: unable to abort current chip operation.
SCSI host 0 abort (pid 0) timed out - resetting

Anyone have an idea how to solve this ?

Thanks in advance, xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
