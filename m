Message-Id: <20011008000445.Postino-003420@smtp01.highway.ne.jp>
Date: Mon, 8 Oct 2001 00:04:45 +0900
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
In-Reply-To: <v03110700b7e6165a1f85@[64.230.145.122]>
References: <v03110700b7e6165a1f85@[64.230.145.122]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
Date: Sun, 7 Oct 2001 10:38:19 -0400

>
> Hi,
>
> I just built and tried the latest 2.4.11 kernel of Ben's and still can't
> get the Radeon or the AIC-7XXX Adaptec SCSI PCI card (from Apple) to work.

>
> Has that older driver been removed?  Does anyone know the e-mail address
of
> the maintainer that I could contact directly (Justin T. Gibbs)?
>
> Any ideas welcome!

HI!

I doen't have Radeon but Adaptec scsi works WELL on Ben's-2.4.10.
Yet, I don't try 2.4.11.
Ben's 2.4.10 has already radeonfb-0.1.0 by Ani.

The 2.4.10 is at

ftp://sv.linuxjp.org/pub/PPC/kernel-2.4.x.Ben/

Kaoru
----------my dmesg ----------------------
Total memory = 320MB; using 1024kB for hash table (at c0400000)
Linux version 2.4.10-B0c (root@g4mpKFUKUI) (gcc version 3.0.2 20011003 (prerelease))
 #1 Fri Oct 5 21:19:12 JST 2001
Found a Paddington mac-io controller, rev: 0, mapped at 0xfdc80000
PowerMac motherboard: Blue&White G3
Found Grackle (MPC106) PCI host bridge at 0x80000000. Firmware bus number:
0->1
On node 0 totalpages: 81920
zone(0): 81920 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda7

<snip>

ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940B Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi2 : MESH
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
 /dev/scsi/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
