From: Marco Reichwald <marcoppc@gmx.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: mol hangs at startup
Date: Wed, 27 Oct 1999 20:40:35 -0400
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99102720415501.00801@marco>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried to run MoL on my beige G3 without luck. (I'm using an unpatched generic
2.2.13 Kernel) 
I don't no much about asm but when I use the debugger, mol seems
to be caught in a endless-loop between adress 0x0 and the "Trap_700_Program"
(whatever this is) 
I get no error messages and no video output, it just hangs.
I tried to disable everything and boot from an "Disk Tools" floppy image. Same
problem.
Any ideas?


Mac-on-Linux 0.9.22 
(C) 1997-1999 Samuel Rydh, <samuel@ibrium.se>
Using resource file '/etc/molrc'
in_security_mode 0
MOL kernel module 1.1.22
OF Device tree copied from kernel
Loading OF device tree from 'oftrees/oftree.8500'
32MB RAM mapped at 0x20000000
4096K ROM mapped at 0x4fc00000 from 'rom/rom.g3'
ROM checksum = 0x134
Running in PowerPC 604 mode
DEC frequency: 0x00fee5e8 (16 MHx), 167:10 mticks/usec
Running on VT 8.
Using console mouse driver
Initing PCI bus services
PCI-bridge 'bandit' (bus 0..0) installed at 0xf2000000
PCI-bridge 'chaos' (bus 1..1) installed at 0xf0000000
GC, Grand Central, (0:16) found
Descriptor based DMA services inited
Using nvram-image 'nvram/nvram.8500.image'
Floppy image 'images/floppy' used for drive A.
Swim3 floppy driver installed
AWACS disabled
Hammerhead driver installed
Control driver disabled (no pci entry added)
osi_enet: *** OSI ENET DISABLED**
53c94 SCSI-driver installed (IRQs 12/0)
Could not register MESH SCSI unit. Need a second bus ??

SCSI-Disk (hw-0):    0 MB

driver_mgr_list: hacks console pci gc pic dbdma via-cuda adb nvram escc swim3 hammerhead mol_video scsi 
Starting emulation...

here it hangs  

------------------------------------------------
hooray for captain spalding!
-------------------------------------------------------

-- 

------------------------------------------------
hooray for captain spalding!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
