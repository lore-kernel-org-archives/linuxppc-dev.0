To: hcd1@acpub.duke.edu
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: SCSI host detected, but not the drive
From: Kazumitsu Hanai <hanai@koto.kpu-m.ac.jp>
In-Reply-To: <Pine.SOL.3.91.990827144757.13651A@godzilla6.acpub.duke.edu>
References: <Pine.SOL.3.91.990827144757.13651A@godzilla6.acpub.duke.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990828075910S.hanai@koto.kpu-m.ac.jp>
Date: Sat, 28 Aug 1999 07:59:10 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

A kernel argument "ncr53c8xx=nvram:n" in the BootX window may help you.
You can find many parameters for the ncr53c8xx scsi driver in README.ncr53c8xx
that is contained in the kernel source/drivers/scsi. "nvram:n" is one of the
best known parameters, when the driver cannot find the drive.

On Fri, 27 Aug 1999 15:02:22 -0400 (EDT),
 Hank De Gregorio <hcd1@acpub.duke.edu> wrote: 
> 
> when i boot my initrd kernel, the scsi host is detected, but the actual 
> drive is not identified (see first set of errors below).  consequently, in 
> the redhat installer, i get the second set of errors below.
> 
> can anyone help me?  my system is an mvme2604 333MHz, with a red rock 
> card with seagate scsi disk and a 761 IO transition module.
> 
> hank
> 
> ncr53c8xx: at PCI bus 0, device 12, function 0
> ncr53c8xx: 53c825a detected
> ncr53c825a-0: rev=0x13, base=0x1042000, io_port=0x11000, irq=19
> ncr53c825a-0: ID 7, Fast-10, Parity Checking
> ncr53c825a-0: on-chip RAM at 0x1040000
> ncr53c825a-0: restart (scsi reset).
> ncr53c825a-0: Downloading SCSI SCRIPTS.
> scsi0 : ncr53c8xx - revision 3.1h
> scsi : 1 host.
> scsi : detected total.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
