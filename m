Date: Fri, 27 Aug 1999 15:02:22 -0400 (EDT)
From: Hank De Gregorio <hcd1@acpub.duke.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-user@lists.linuxppc.org
Subject: SCSI host detected, but not the drive
Message-ID: <Pine.SOL.3.91.990827144757.13651A@godzilla6.acpub.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


when i boot my initrd kernel, the scsi host is detected, but the actual 
drive is not identified (see first set of errors below).  consequently, in 
the redhat installer, i get the second set of errors below.

can anyone help me?  my system is an mvme2604 333MHz, with a red rock 
card with seagate scsi disk and a 761 IO transition module.

hank

ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: 53c825a detected
ncr53c825a-0: rev=0x13, base=0x1042000, io_port=0x11000, irq=19
ncr53c825a-0: ID 7, Fast-10, Parity Checking
ncr53c825a-0: on-chip RAM at 0x1040000
ncr53c825a-0: restart (scsi reset).
ncr53c825a-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - revision 3.1h
scsi : 1 host.
scsi : detected total.
eth0: DC21140 at 0x11100 (PCI bus 0, device 14), h/w address 
08:00:3e:28:53:a2,
      and requires IRQ18 (provided by PCI BIOS).


		 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ Setup Swap ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                 ³                                            ³
                 ³ You don't have any hard drives available!  ³
                 ³ You probably forgot to configure a SCSI    ³
                 ³ controller.                                ³
                 ³                                            ³
                 ³                                            ³
                 ³                                            ³
                 ³                 ÚÄÄÄÄ¿                     ³
                 ³                 ³ Ok ³                     ³
                 ³                 ÀÄÄÄÄÙ                     ³
                 ³                                            ³
                 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
