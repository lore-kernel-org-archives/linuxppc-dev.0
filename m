Message-ID: <01BE9277.54A64960.AR@aid-computers.de>
From: Andreas Reeh <AR@aid-computers.de>
To: "'linuxppc-user'" <linuxppc-user@lists.linuxppc.org>
Cc: "'linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>
Subject: LinuxPPC installation horror !!! / NCR53c875 problem ?
Date: Thu, 29 Apr 1999 19:34:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I spent about 12 hours this day trying to install LinuxPPC R4.1 (yes I 
received the cd today morning after waiting WEEKS for the ordered R5) and I 
am short b4 jumping out of the windows .... :-(((((

Why ?

I have a system with a Motorola MTX 604 - 003a motherboard, this is prep, 
has pci and scsi (with a ncr53c875 chip) and vga.

The first problem was that the prep.img on the cd. I made a nice 
floppy-bootdisk from it with dd and - yeah, it booted !
But it seems that it did not find my scsi controler and devices (first I 
thought it is only the cd-rom and tried to put the cd in an other machine 
and tried to install over ftp but then I noticed that the disk could not be 
found too), there is no message from the kernel mentioning anything with 
scsi.
Ok, no problem I thought, just get a newer installdisk. So I downloaded 
ftp://ftp.linuxppc.org/pub/linuxppc/linuxppc-R4/install/PREP/zImage.prep  
-installer-2.2.0-990129 and had much problems getting it to boot from 
somewhere because it was to big for a normal floppy (see other threads on 
this list from today).

But finally I found two ways which allowd me to boot (the one was from a 
dat tape, the other from a small partition on the disk partitioned in a x86 
linux machine) - but both end with the same problem:

"ncr53c8xx: at PCI bus 0, device 12, function 0
 ncr53c8xx:  53c875 detected
 ncr53c875-0: rev=0x04, base=0x1fffe00, io_port=0xffffe00, irq=14
 ncr53c875-0: NCR clock is 60056KHz, 60056KHz
 ncr53c875-0: ID 7, Fast-20, Parity Checking
 ncr53c875-0: on-chip RAM at 0x1ffe000
 ncr53c875-0: restart (scsi reset)
 ncr53c875-0: Downloading SCSI SCRIPTS.
 scsi0 : ncr53c8xx - revision 3.1f
 scsi : 1 host.
 scsi : aborting command due to tomeout : pid 0, scsi0, channel0, id0, lun 
0x00 00 00 00 00 00
 ncr5c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1"

and this was the end ... now only the reset switch works ....


Two things I think I should mention:
Linux detects a ncr53c875-0 but I can read "LSI Symbios tm 53c875J" on the 
motherboards chip - is this correct ?

The other thing: last week I found a 2.0.33 kernel (just the zimage, no 
installer) which booted this system and which FOUND the scsi disk and 
cd-rom !
The same behavior with a installer-image for R5 (I think it is for R5 but I 
can't renember exactely where I got it), it has a 2.2.1 kernel and finds 
the disk and cd, but I think because of differents between the R4.1 and R5 
cd content it does not install anything (on console 2 (or 3 or 4 ? forgot 
it) there is something like "no such file" ...)

Now - WHAT could I do !?  It would be SOOOOOOOOOOO GREAT if I could use 
linuxppc on this system but at the moment I see no more chance what I could 
do :-((((

Any tips ?
Please help !!!  Please !!!     (b4 I start getting bad dreams from this)

--
Andreas Reeh			(technischer Support)
AID Computers AG		Tel:	+49-2234-95310-19
Max-Planck-Strasse 22		Fax:	+49-2234-56088
D-50858 Koeln (Marsdorf)	Mail:	ar@aid-computers.de
GERMANY			Web:	http://www.aid-computers.de/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
