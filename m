Message-ID: <38F3C93A.5BEDC95F@amberdata.demon.co.uk>
Date: Wed, 12 Apr 2000 01:54:18 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Prep interrupt routing (carolina-type board)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,


Does anybody know for sure if the ibm8xx_pci_IRQ_map structure in
prep_pci.c is correct? I'm trying to use an ncr53c825 board in one of
the PCI slots, and I'm getting the exact symptoms I used to get on my
intel box when the PCI bios screwed up and assigned the wrong irq to it
(it goes into an endless loop:

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Te
st Unit Ready 00 00 00 00 00
ncr53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1


etc...)

Should the PCI interrupts turn up in the residual data in one of these
boards?

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
