Date: Tue, 12 Jan 1999 19:53:11 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990106100301.1602A-100000@cricket>
Message-ID: <Pine.LNX.3.95.990112104748.31123B-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


paul,

i'd like to try fixing this by inserting delays into the mesh target
discovery. could you point me to the right place to do this and the
correct way to introduce a delay in the kernel? 

(i can't check to see if you've already done this in vger--it's refusing
cvs connections)

thanks
brad

> 
> turning off the target debugging "allowed" the drive to abort again.  log
> is appended. 
> 
> brad
> 
> DB mouse driver installed.
> AWACS: error, status = 40210f
> DMA sound driver installed, using 4 buffers of 32k.
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> fd0: SWIM3 floppy controller 
> scsi0 : MESH
> scsi1 : 53C94
> scsi : 2 hosts.
> mesh: target 0 synchronous at 5.0 MB/s
>   Vendor: QUANTUM   Model: PD1225S           Rev: 3110
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> mesh: target 1 aborted
> mesh log 1: bs=0000 ph=01 start cmd=c2fdbe00
> mesh log 1: bs=0000 ph=01 about to arb, intr/exc/err/fc=00000000
> mesh log 1: bs=6000 ph=01 after arb, intr/exc/err/fc=01000000
> mesh log 1: bs=6000 ph=01 interrupt intr/err/exc/seq=01000001
> mesh log 1: bs=6000 ph=01 cmd_complete fc=0
> mesh log 1: bs=6000 ph=02 start_phase err/exc/fc/seq = 00000001
> mesh log 1: bs=4008 ph=02 interrupt intr/err/exc/seq=01000022
> mesh log 1: bs=4008 ph=02 cmd_complete fc=0
> mesh log 1: bs=4008 ph=02 Selecting phase at command completion
> mesh log 1: bs=4008 ph=03 start_phase err/exc/fc/seq = 00000022
> mesh log 1: bs=0000 ph=03 interrupt intr/err/exc/seq=05400000
> mesh log 1: bs=0000 ph=03 error err/exc/fc/cl=40000600
> mesh log: bs=4013 ph=46 t0 start_phase err/exc/fc/seq = 00000014
> mesh log: bs=4017 ph=46 t0 interrupt intr/err/exc/seq=01000018
> mesh log: bs=4017 ph=46 t0 cmd_complete fc=1
> mesh log: bs=4017 ph=06 t0 msgin msg=01000301
> mesh log: bs=4017 ph=06 t0 start_phase err/exc/fc/seq = 00000018
> mesh log: bs=4017 ph=06 t0 enbresel intr/exc/err/fc=00000000
> mesh log: bs=0000 ph=06 t0 interrupt intr/err/exc/seq=01000009
> mesh log: bs=0000 ph=06 t0 cmd_complete fc=0
> mesh log: bs=0000 ph=01 t1 start cmd=c2fdbe00
> mesh log: bs=0000 ph=01 t1 about to arb, intr/exc/err/fc=00000000
> mesh log: bs=6000 ph=01 t1 after arb, intr/exc/err/fc=01000000
> mesh log: bs=6000 ph=01 t1 interrupt intr/err/exc/seq=01000001
> mesh log: bs=6000 ph=01 t1 cmd_complete fc=0
> mesh log: bs=6000 ph=02 t1 start_phase err/exc/fc/seq = 00000001
> mesh log: bs=4008 ph=02 t1 interrupt intr/err/exc/seq=01000022
> mesh log: bs=4008 ph=02 t1 cmd_complete fc=0
> mesh log: bs=4008 ph=02 t1 Selecting phase at command completion
> mesh log: bs=4008 ph=03 t1 start_phase err/exc/fc/seq = 00000022
> mesh log: bs=0000 ph=03 t1 interrupt intr/err/exc/seq=05400000
> mesh log: bs=0000 ph=03 t1 error err/exc/fc/cl=40000600
> mesh: target 3 synchronous at 4.2 MB/s
>   Vendor: SONY      Model: CD-ROM CDU-8005   Rev: 1.0j
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
>   Vendor: QUANTUM   Model: CTS80S            Rev: 4.2 
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sdb at scsi1, channel 0, id 4, lun 0
> scsi : detected 1 SCSI cdrom 2 SCSI disks total.
> sr0: disc change detected.
> Uniform CDROM driver Revision: 2.51
> SCSI device sda: hdwr sector= 512 bytes. Sectors= 2395980 [1169 MB] [1.2 GB]
> SCSI device sdb: hdwr sector= 512 bytes. Sectors= 166200 [81 MB] [0.1 GB]
> eth0: MACE at 00:05:02:e0:03:4f
> Partition check:
>  sda: sda1 sda2 sda3 sda4 sda5
>  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
> 
> 
> 




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
