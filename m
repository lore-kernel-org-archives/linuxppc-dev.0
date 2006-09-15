Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (unknown [220.227.188.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0622E67B22
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 15:10:26 +1000 (EST)
Received: from innomedia ([192.168.18.10]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.12.11/8.12.11) with ESMTP id
	k8F5AI2o013910
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Sep 2006 10:40:18 +0530
Message-ID: <014e01c6d884$dee21900$0a12a8c0@innomedia>
From: "Akhilesh Soni" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: IDE DMA Issue PPC4xx
Date: Fri, 15 Sep 2006 10:37:41 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_014B_01C6D8B2.F890B810"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_014B_01C6D8B2.F890B810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,


I'm using IBM redwood6 stb025xx(ppc405gp) platform with 2.6.14 kernel. =
I'm trying to get DMA working for IDE interface (PIO is working). The =
problem I'm facing is that my DMA is completing and I'm getting a error =
in DMA status register that "A DMA  request from an external device is =
pending"

I'm attaching (inline) the console message(in red color) along with the =
sample code of the driver(in blue color). Please help me to resolve this =
issue. What I feel is that DMA is completing and IDE is not getting =
anything. ( IDE status register is giving 0x58).=20

Any pointers to same will be highly appreciated.


Regards,
Akhilesh



IBM Set-Top-Box BIOS 1.50 (Feb-16-2004)

Platform support <Redwood6/STBx25xx 1.03 (Jun/24/2002)>


Initializing devices, please wait.....
                                        =20

 ------- System Info --------

 Processor speed =3D 252 MHz

 EBIU speed      =3D 63 MHz

 Amount of RAM   =3D 64 MBytes

DM9000 : dmfe_probe() : Checking DM9000 chip=20

DM9000 : Chip Found ID : 90000a46=20


 --- Device Configuration ---

 Power-On Test Devices:

   000  Disabled  System Memory [RAM]

 ----------------------------

 Boot Sources:

   001  Disabled  Application in Flash [FLASH]

   002  Enabled   Ethernet [ENET]

                  local=3D192.168.18.28  remote=3D192.168.18.101  =
hwaddr=3Dbad0add00000

   003  Disabled  Serial Port 1 [S1]

                  Baud =3D 9600

 ----------------------------

Update Flash  : Disabled=20

Automatic Boot: Disabled

 ----------------------------

  1 - Toggle Power-On Tests

  2 - Change a Boot Device

  3 - Change IP Addresses

  4 - Ping test

  5 - Change Baud Rate for S1 Boot

  6 - Toggle Update Flash

  7 - Toggle Automatic Boot

  B - Bootlogo Management

  D - Display Configuration

  S - Save Changes

  Z - Set Ethernet HW Address

  0 - Exit Menu and Boot Application

  C - Enable CHOIS Debug=20

->0

DM900 : dmfe_init_dm9000 : initialising dm9000

Booting from [ENET] Ethernet...

Sending bootp request ...

 bootp packets sent =3D 1
DM900 : dmfe_send : hold frame collision, outbound frame.


Got bootp response from : 192.168.18.101

       My ip address is : 192.168.18.28


Loading file "zImage.treeboot" by TFTP for net boot ...

 block  268
 block 1440
Transfer completed, 897568 bytes received

Loaded successfully ...

Entry point at 0x500000 ...


loaded at:     00500000 005DC164

relocated to:  00400000 004DC164

board data at: 004DA124 004DA164

relocated to:  0040515C 0040519C

zimage at:     0040591D 004D9A6C

avail ram:     004DD000 02000000


Linux/PPC load: ip=3Don

Uncompressing Linux...done.

Now booting the kernel

Linux version 2.6.14 (root@localhost.localdomain) (gcc version 4.0.0 =
(DENX ELDK 4.0 4.0.0)) #258 Wed Sep 13 16:12:58 IST 2006

ocp: ocp_early_init()...

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_add_one_device()...

ocp: ocp_add_one_device()...done

ocp: ocp_early_init()... done.

IBM Redwood6 (STBx25XX) Platform

Port by MontaVista Software, Inc. (source@mvista.com)

Built 1 zonelists

Kernel command line: ip=3Don

PID hash table entries: 256 (order: 8, 4096 bytes)

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 30488k available (1452k kernel code, 344k data, 96k init, 0k =
highmem)

Mount-cache hash table entries: 512

NET: Registered protocol family 16

ocp: ocp_driver_init()...

ocp: ocp_driver_init()... done.

Adding platform devices=20

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled

ttyS0 at MMIO 0x0 (irq =3D 22) is a 16550A

ttyS1 at MMIO 0x0 (irq =3D 20) is a 16550A

ttyS2 at MMIO 0x0 (irq =3D 21) is a 16550A

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

loop: loaded (max 8 devices)

dm9000 Ethernet Driver

dm9000_set_io : byte_width 2

eth0: dm9000 at c3000000,c3000004 IRQ 26 MAC: ba:d0:ad:d0:00:00

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx

NET: Registered protocol family 2

IP route cache hash table entries: 512 (order: -1, 2048 bytes)

TCP established hash table entries: 2048 (order: 1, 8192 bytes)

TCP bind hash table entries: 2048 (order: 1, 8192 bytes)

TCP: Hash tables configured (established 2048 bind 2048)

TCP reno registered

TCP bic registered

NET: Registered protocol family 1

inside stb04xxx_ide_init=20

IBM STB025xx OCP IDE driver version 1.0 f2100000=20

ide_redwood: waiting for drive ready......Drive spun up=20

ocp_ide_setup_dma=20

probing for hda: present=3D0, media=3D32, probetype=3DATA

hda: probing with STATUS(0x51) instead of ALTSTATUS(0x00)

hda: WDC WD400EB-00CPF0, ATA DISK drive

probing for hdb: present=3D0, media=3D32, probetype=3DATA

probing for hdb: present=3D0, media=3D32, probetype=3DATAPI

hdb: probing with STATUS(0x01) instead of ALTSTATUS(0x00)

ocp_ide_tune_drive pio 4

got ocp_ide_dma_off_quietly

got ocp_ide_dma_check

redwood_config_drive_for_dma 22

ocp_ide_tune_drive pio 4

got ocp_ide_dma_on

ide0 at 0xc3004000-0xc3004007,0xc3006000 on irq 27

hda: max request size: 128KiB

ide_execute_command : 0x91

ide_execute_command : 0x10

ide_execute_command : 0xf8

hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63, =
(U)DMA

hda: cache flushes not supported

 hda:__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c0340000 340000 count 8 dmastat 0

got ocp_ide_dma_test_irq

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 50

DMA complete stat 0 500000

 hda1

IDE probe finished=20

eth0: link up, 100Mbps, full-duplex, lpa 0x41E1

Sending BOOTP and RARP requests . OK

IP-Config: Got BOOTP answer from 192.168.18.101, my address is =
192.168.18.28

IP-Config: Complete:

      device=3Deth0, addr=3D192.168.18.28, mask=3D255.255.255.0, =
gw=3D192.168.18.1,

     host=3D192.168.18.28, domain=3D, nis-domain=3D(none),

     bootserver=3D192.168.18.101, rootserver=3D192.168.18.101, =
rootpath=3D/opt/eldk/ppc_4xx

Looking up port of RPC 100003/2 on 192.168.18.101

Looking up port of RPC 100005/1 on 192.168.18.101

VFS: Mounted root (nfs filesystem) readonly.

Freeing unused kernel memory: 96k init

modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory


INIT: version 2.85 booting
 Came here in rc.sysinit creating var\n
mounting=20
ln: `/proc/mounts': File exists
  Welcome to DENX Embedded Linux Environment
  Press 'I' to enter interactive startup.
Building the cache [  OK  ]
 storage network audio done[  OK  ]
modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory

Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access =
method.
Setting clock : Thu Jan  1 01:00:12 MET 1970 [  OK  ]
Setting hostname CHOISpad-110:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]

INIT: Entering runlevel: 3
Entering non-interactive startup
Bringing up loopback interface:  modprobe: FATAL: Could not load =
/lib/modules/2.6.14/modules.dep: No such file or directory

arping: socket: Address family not supported by protocol
Error, some other host already uses address 127.0.0.1.
[FAILED]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmap: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.0 build 2006-01-11
Linux 2.6.14 on a ppc

CHOISpad-110 login: root
Last login: Thu Jan  1 01:00:19 on console
bash-3.00#=20
bash-3.00#=20
bash-3.00#=20
bash-3.00#=20
bash-3.00#=20
bash-3.00# hdparm -t=08 =08=08 =08/dev/hda

/dev/hda:
 multcount    =3D  0 (off)
 I/O support  =3D  0 (default 16-bit)
 unmaskirq    =3D  1 (on)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 nowerr       =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 geometry     =3D 65535/16/63, sectors =3D 78165360, start =3D 0
bash-3.00#=20
bash-3.00#=20
bash-3.00#=20
bash-3.00#=20
bash-3.00# hdparm -t /dev/hda

/dev/hda:
 Timing buffered__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

 disk reads:  got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

ide_execute_command : 0x10

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

got ocp_ide_dma_off_quietly

ide0: reset: master: error (0x00?)

ide_execute_command : 0x91

ide_execute_command : 0x10

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

ide_execute_command : 0x10

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0

got ocp_ide_dma_setup=20

ide_execute_command : 0xc8

got ocp_ide_dma_begin 0x1000

DMA addr c1238000 1238000 count 8 dmastat 0

DMA complete stat 20001000 0

hda: lost interrupt

got ocp_ide_dma_end 0 20000000

ide_dma_intr : stat 58

hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown

got ocp_ide_dma_off_quietly

ide0: reset: master: error (0x00?)

end_request: I/O error, dev hda, sector 0

Buffer I/O error on device hda, logical block 0

end_request: I/O error, dev hda, sector 8

Buffer I/O error on device hda, logical block 1

end_request: I/O error, dev hda, sector 16

Buffer I/O error on device hda, logical block 2

end_request: I/O error, dev hda, sector 24

Buffer I/O error on device hda, logical block 3

end_request: I/O error, dev hda, sector 32

Buffer I/O error on device hda, logical block 4

end_request: I/O error, dev hda, sector 40

Buffer I/O error on device hda, logical block 5

end_request: I/O error, dev hda, sector 48

Buffer I/O error on device hda, logical block 6

end_request: I/O error, dev hda, sector 56

Buffer I/O error on device hda, logical block 7

end_request: I/O error, dev hda, sector 64

Buffer I/O error on device hda, logical block 8

end_request: I/O error, dev hda, sector 72

Buffer I/O error on device hda, logical block 9

end_request: I/O error, dev hda, sector 80

end_request: I/O error, dev hda, sector 88

end_request: I/O error, dev hda, sector 96

end_request: I/O error, dev hda, sector 104

end_request: I/O error, dev hda, sector 112

end_request: I/O error, dev hda, sector 120

end_request: I/O error, dev hda, sector 128

end_request: I/O error, dev hda, sector 136

end_request: I/O error, dev hda, sector 144

end_request: I/O error, dev hda, sector 152

end_request: I/O error, dev hda, sector 160

end_request: I/O error, dev hda, sector 168

end_request: I/O error, dev hda, sector 176

end_request: I/O error, dev hda, sector 184

end_request: I/O error, dev hda, sector 192

end_request: I/O error, dev hda, sector 200

end_request: I/O error, dev hda, sector 208

end_request: I/O error, dev hda, sector 216

end_request: I/O error, dev hda, sector 224

end_request: I/O error, dev hda, sector 232

end_request: I/O error, dev hda, sector 240

end_request: I/O error, dev hda, sector 248

end_request: I/O error, dev hda, sector 256

end_request: I/O error, dev hda, sector 264

end_request: I/O error, dev hda, sector 272

end_request: I/O error, dev hda, sector 280

end_request: I/O error, dev hda, sector 288

end_request: I/O error, dev hda, sector 296

end_request: I/O error, dev hda, sector 304

end_request: I/O error, dev hda, sector 312

end_request: I/O error, dev hda, sector 320

end_request: I/O error, dev hda, sector 328

end_request: I/O error, dev hda, sector 336

end_request: I/O error, dev hda, sector 344

end_request: I/O error, dev hda, sector 352

end_request: I/O error, dev hda, sector 360

end_request: I/O error, dev hda, sector 368

end_request: I/O error, dev hda, sector 376

end_request: I/O error, dev hda, sector 384

end_request: I/O error, dev hda, sector 392

end_request: I/O error, dev hda, sector 400

end_request: I/O error, dev hda, sector 408

end_request: I/O error, dev hda, sector 416

end_request: I/O error, dev hda, sector 424

end_request: I/O error, dev hda, sector 432

end_request: I/O error, dev hda, sector 440

end_request: I/O error, dev hda, sector 448

end_request: I/O error, dev hda, sector 456

end_request: I/O error, dev hda, sector 464

end_request: I/O error, dev hda, sector 472

end_request: I/O error, dev hda, sector 480

end_request: I/O error, dev hda, sector 488

end_request: I/O error, dev hda, sector 496

end_request: I/O error, dev hda, sector 504

end_request: I/O error, dev hda, sector 0

read() failed: Input/output error
bash-3.00#=20






static void ocp_ide_dma_begin(ide_drive_t *drive){
int i,reading=3D0,length;
struct request * const rq =3D HWGROUP(drive)->rq;
unsigned long control;

 if(rq_data_dir (rq) =3D=3D READ) reading =3D 1;

 printk("got ocp_ide_dma_begin 0x%x\n",mfdcr(DCRN_DMASR));
 /* enable DMA */
 ppc4xx_enable_dma_interrupt(IDE_DMACH);
 /*dmastat =3D mfdcr(DCRN_DMASR);
 mtdcr(DCRN_DMASR,((u32)DMA_CH2_ERR | (u32)DMA_CS2 | (u32)DMA_TS2));
 */
 mtdcr(DCRN_DMASR,0x22200120);
 /*Configure CIC reg for line mode DMA*/
#ifdef WMODE
 mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) | 0x00000400));
#else
 mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) & ~0x00000400));

#endif

 if(drive->media !=3D ide_disk) {
  printk("ocp_ide_dma_begin : Invalid media \n");
  return;
 }
 if(ppc4xx_get_channel_config(IDE_DMACH,&dma_ch) & DMA_CHANNEL_BUSY){
   printk("DMA channel busy \n");
   return;
 }
 memset(rq->buffer,0,rq->current_nr_sectors*512);
 if(reading){
 =20
  dma_cache_inv((unsigned long) rq->buffer, rq->current_nr_sectors * =
512);
#ifdef WMODE
  mtdcr(DCRN_DMASA2,(u32)0x00000000);// set src address for DMA channel =
2
  mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq->buffer));//set dst address for =
DMA channel 2
  mtdcr(DCRN_DCRXBCR,0x00000000);
  control =3D 0xE600CB02;
#else
  mtdcr(DCRN_DMASA2,(u32)0xfce00000);// set src address for DMA channel =
2
  mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq->buffer));//set dst address for =
DMA channel 2
  mtdcr(DCRN_DCRXBCR,0x90000000);
  control =3D 0xEE602b02;
#endif
 }
 else {
  dma_cache_wback_inv((unsigned long) rq->buffer, rq->current_nr_sectors =
* 512);

#ifdef WMODE
  mtdcr(DCRN_DMASA2,(u32)0x00000000);// set dst address for DMA channel =
2
  mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq->buffer));// set src address for =
DMA channel 2
  mtdcr(DCRN_DCRXBCR,0x00000000);
  control =3D 0xC600CB02;
#else
  mtdcr(DCRN_DMADA2,(u32)0xfce00000);// set dst address for DMA channel =
2
  mtdcr(DCRN_DMASA2,(u32)virt_to_bus(rq->buffer));// set src address for =
DMA channel 2
  mtdcr(DCRN_DCRXBCR,0xB0000000);
  control =3D 0xcd602b02;
#endif

 }

#ifdef WMODE
 length =3D (rq->current_nr_sectors *512)/2;
#else
 length =3D (rq->current_nr_sectors *512)/16;
#endif
 mtdcr(DCRN_DMACT2,length);

 /*control =3D mfdcr(DCRN_DMACR2);
 control |=3D DMA_CIE_ENABLE;  Channel Interrupt Enable=20
 */
 control &=3D ~DMA_CIE_ENABLE;
 mtdcr(DCRN_DMACR2, control);
 //ppc4xx_enable_dma_interrupt(IDE_DMACH);
=20
 printk("DMA addr %x %x count %d dmastat =
%x\n",rq->buffer,virt_to_bus(rq->buffer),rq->current_nr_sectors,dmastat);=

 /* wait for dma to complete (channel 2 terminal count) */
 for (i =3D 0; i < 500000; i++) {
  if(i%1000 =3D=3D 0)
   dmastat =3D mfdcr(DCRN_DMASR);
  if (dmastat & DMA_CS2)
   break;
 }
 printk("DMA complete stat %x %d\n",dmastat,i);
 mtdcr(DCRN_DCRXBCR,0x00000000);
 mtdcr(DCRN_DMACR2, 0x00000000);
 drive->waiting_for_dma =3D 0;
 //dmastat =3D 0;
}
static int ocp_ide_dma_end(ide_drive_t *drive){
unsigned int tmp =3D mfdcr(DCRN_DMASR);

 mtdcr (DCRN_UIC_SR(UIC0),(0x80000000ul >> IDE_DMA_INT));
 mtdcr(DCRN_DMASR,0x22200120);
 dmastat =3D mfdcr(DCRN_DMASR);
 printk("got ocp_ide_dma_end %x %x\n",dmastat,tmp);
 drive->waiting_for_dma =3D 0;
 /* disable DMA */
 //ppc4xx_disable_dma_interrupt(IDE_DMACH);

 return 0;
}

static void
ocp_ide_setup_dma (ide_hwif_t * const hwif)
{
 printk("ocp_ide_setup_dma \n");


 hwif->dma =3D IDE_DMACH;
#ifdef WMODE
   /*Word Mode psc(11-12)=3D00,pwc(13-18)=3D000110, phc(19-21)=3D010, =
22=3D1, 30=3D1  ----  0xCB02*/

 dma_ch.mode =3DTM_S_MM;   /* xfer from peripheral to mem */
 dma_ch.td =3D DMA_TD;
 dma_ch.buffer_enable =3D FALSE;
 dma_ch.tce_enable =3D FALSE;
 dma_ch.etd_output =3D FALSE;
 dma_ch.pce =3D FALSE;
 dma_ch.pl =3D EXTERNAL_PERIPHERAL;    /* no op */
 dma_ch.pwidth =3D PW_16;
 dma_ch.dai =3D TRUE;
 dma_ch.sai =3D FALSE;
 dma_ch.psc =3D 0;                      /* set the max setup cycles */
 dma_ch.pwc =3D 6;                     /* set the max wait cycles  */
 dma_ch.phc =3D 2;                      /* set the max hold cycles  */
 dma_ch.cp =3D PRIORITY_LOW;
 dma_ch.int_enable =3D FALSE;
 dma_ch.ch_enable =3D FALSE;  /* No chaining */
 dma_ch.tcd_disable =3D TRUE;  /* No chaining */
#else
/*Line Mode psc(11-12)=3D00,pwc(13-18)=3D000001, phc(19-21)=3D010, =
22=3D1, 30=3D1  ----  0x2B02*/

 dma_ch.mode =3DDMA_MODE_MM_DEVATSRC;   /* xfer from peripheral to mem =
*/
 dma_ch.td =3D DMA_TD;
 dma_ch.buffer_enable =3D FALSE;
 dma_ch.tce_enable =3D FALSE;
 dma_ch.etd_output =3D FALSE;
 dma_ch.pce =3D FALSE;
 dma_ch.pl =3D EXTERNAL_PERIPHERAL;    /* no op */
 dma_ch.pwidth =3D PW_64;  /* Line mode on stbs */
 dma_ch.dai =3D TRUE;
 dma_ch.sai =3D FALSE;
 dma_ch.psc =3D 0;                      /* set the max setup cycles */
 dma_ch.pwc =3D 1;                     /* set the max wait cycles  */
 dma_ch.phc =3D 2;                      /* set the max hold cycles  */
 dma_ch.cp =3D PRIORITY_LOW;
 dma_ch.int_enable =3D FALSE;
 dma_ch.ch_enable =3D FALSE;  /* No chaining */
 dma_ch.tcd_disable =3D TRUE;  /* No chaining */

#endif
 if (ppc4xx_init_dma_channel(IDE_DMACH, &dma_ch) !=3D DMA_STATUS_GOOD){
  printk("ppc4xx_init_dma_channel failed\n");
         return -EBUSY;
 }
 //ppc4xx_disable_dma_interrupt(IDE_DMACH);

 /*init CIC control register to enable IDE interface PIO mode*/
 mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) & 0xffff7bff) | 0x00000003);
 mtdcr(DCRN_DMACR2, 0);
 ppc4xx_clr_dma_status(IDE_DMACH);
 /* init CIC select2 reg to connect external DMA port 3 to internal
  * DMA channel 2

  */
 mtdcr(DCRN_DMAS2,(mfdcr(DCRN_DMAS2) & 0xfffffff0) | 0x00000002);


 hwif->autodma =3D 1;hwif->udma_four=3D0;
 hwif->drives[0].autotune =3D hwif->drives[1].autotune =3D =
IDE_TUNE_AUTO;
 hwif->drives[0].autodma  =3D hwif->drives[1].autodma  =3D =
hwif->autodma;

 hwif->atapi_dma  =3D 0;
 hwif->ultra_mask =3D hwif->udma_four ? 0x1f : 0x07;
 hwif->mwdma_mask =3D 0x07;
 hwif->swdma_mask =3D 0x00;

 /* set everything to something !=3D NULL */
 hwif->ide_dma_host_off   =3D &ocp_ide_dma_off_quietly;
 hwif->ide_dma_host_on     =3D &ocp_ide_dma_on;

 hwif->ide_dma_check   =3D &ocp_ide_dma_check;
 hwif->ide_dma_off_quietly   =3D &ocp_ide_dma_off_quietly;
 hwif->ide_dma_on            =3D &ocp_ide_dma_on;

 hwif->dma_setup      =3D &ocp_ide_dma_setup;
 hwif->dma_exec_cmd    =3D &ocp_dma_exec_cmd;
 hwif->dma_start       =3D &ocp_ide_dma_begin;
 hwif->ide_dma_end    =3D &ocp_ide_dma_end;

 hwif->ide_dma_test_irq   =3D &ocp_ide_dma_test_irq;

 hwif->ide_dma_lostirq    =3D &ocp_ide_dma_lostirq;
 hwif->ide_dma_timeout    =3D &ocp_ide_dma_timeout;
}
 =20
static int __init
stb025xx_ide_probe (struct ocp_device * const ocp)
{
 int                     err;
 unsigned int            uicdcr;
 volatile unsigned long ide_regs;
 unsigned long           flags,ioaddr;
 ide_hwif_t             * const hwif =3D &ide_hwifs[0];
 unsigned char          * ip;
 int                     i;

 printk ("IBM STB025xx OCP IDE driver version %s %x \n", =
IDEVR,ocp->def->paddr);
 if (!request_region(REDWOOD_IDE_CMD, 0x10, "IDE"))
  return -EBUSY;

 if (!request_region(REDWOOD_IDE_CTRL, 2, "IDE")) {
  release_region(REDWOOD_IDE_CMD, 0x10);
  return -EBUSY;
 }

 ide_regs =3D ioaddr =3D (unsigned long) ioremap(REDWOOD_IDE_CMD, 0x10);

 for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++) {
  hwif->io_ports[i] =3D ioaddr;
  ioaddr +=3D 2;
 }
 hwif->io_ports[IDE_CONTROL_OFFSET] =3D
     (unsigned long) ioremap(REDWOOD_IDE_CTRL, 2);

 ocp_force_power_on (ocp);
=20
 /* initialize */
 hwif->gendev.parent =3D &ocp->dev;
 ocp_set_drvdata (ocp, hwif);

 /* setup MMIO ops */
 default_hwif_mmiops (hwif);

 /* tell common code _not_ to mess with resources */
 hwif->mmio =3D 2;
 ide_set_hwifdata (hwif, (void *) ide_regs);
=20
 hwif->chipset =3D ide_generic;
 hwif->irq     =3D IDE0_IRQ;
 hwif->noprobe =3D 0;
 hwif->hold    =3D 1;
 hwif->udma_four =3D 0;
 hwif->tuneproc  =3D &ocp_ide_tune_drive;
 hwif->speedproc =3D &ocp_ide_tune_chipset;
 hwif->drives[0].io_32bit =3D hwif->drives[1].io_32bit =3D 0;
 hwif->drives[0].unmask   =3D hwif->drives[1].unmask   =3D 1;
 pio_mode[0] =3D pio_mode[1] =3D -1;
=20
 ibm25xx_ide_spinup(0);
 ocp_ide_setup_dma (hwif);
 probe_hwif_init (hwif);

 create_proc_ide_interfaces ();
 printk("IDE probe finished \n");
 return 0;
}
static int ocp_ide_dma_end(ide_drive_t *drive){
unsigned int tmp =3D mfdcr(DCRN_DMASR);

 mtdcr (DCRN_UIC_SR(UIC0),(0x80000000ul >> IDE_DMA_INT));
 mtdcr(DCRN_DMASR,0x22200120);
 dmastat =3D mfdcr(DCRN_DMASR);
 printk("got ocp_ide_dma_end %x %x\n",dmastat,tmp);
 drive->waiting_for_dma =3D 0;
 /* disable DMA */
 //ppc4xx_disable_dma_interrupt(IDE_DMACH);

 return 0;
}
static int ocp_ide_dma_test_irq(ide_drive_t *drive){

 printk("got ocp_ide_dma_test_irq\n");
 return 1; /* returns 1 if dma irq issued, 0 otherwise */
}
static int ocp_ide_dma_verbose(ide_drive_t *drive){

 printk("got ocp_ide_dma_verbose\n");
 return 1;
}
static int ocp_ide_dma_lostirq(ide_drive_t *drive){


 printk("got ocp_ide_dma_lostirq\n");
 return 1;
}
static int ocp_ide_dma_timeout(ide_drive_t *drive){

 printk("got ocp_ide_dma_timeout\n");
 return 1;
}
static void
ocp_dma_exec_cmd (ide_drive_t * const drive, u8 command){
ide_hwif_t *hwif =3D HWIF(drive);

 //hwif->OUTBSYNC(drive,command, IDE_COMMAND_REG);
 //printk("ide_dma_exec_cmd %x\n",command);
 ide_execute_command (drive, command,&ide_dma_intr, 2*WAIT_CMD, NULL);
}
static int ocp_ide_dma_setup(ide_drive_t * const drive){
 ide_hwif_t  * const hwif =3D HWIF(drive);
 struct request * const rq =3D HWGROUP(drive)->rq;

 printk("got ocp_ide_dma_setup \n");
 /*if(rq->current_nr_sectors < 2){
  printk("request for less no of sectors %d\n",rq->current_nr_sectors);
  ide_map_sg(drive,rq);drive->waiting_for_dma=3D0;=20
  return 1;
 }*/
 drive->waiting_for_dma =3D 1;
 return 0;
}=20


------=_NextPart_000_014B_01C6D8B2.F890B810
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi All,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using IBM redwood6 =
stb025xx(ppc405gp) platform=20
with 2.6.14 kernel. I'm trying to get DMA working for IDE interface (PIO =
is=20
working). The problem I'm facing is that my DMA is completing and I'm =
getting a=20
error in DMA status register that "A DMA&nbsp; request from an external=20
device&nbsp;is pending"</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm attaching (inline) the console =
message(in red=20
color)&nbsp;along with the sample code of the driver(in blue color). =
Please help=20
me to resolve this issue. What I feel is that DMA is completing and IDE =
is not=20
getting anything. ( IDE status register is giving 0x58). </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any pointers to same will be highly=20
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IBM Set-Top-Box BIOS 1.50 =
(Feb-16-2004)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Platform support &lt;Redwood6/STBx25xx 1.03=20
(Jun/24/2002)&gt;</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>Initializing devices, please=20
wait.....<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;------- System Info =
--------</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;Processor speed =3D 252 =
MHz</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;EBIU =
speed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 63=20
MHz</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;Amount of RAM&nbsp;&nbsp; =3D 64=20
MBytes</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DM9000 : dmfe_probe() : Checking DM9000 chip=20
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DM9000 : Chip Found ID : 90000a46 =
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>&nbsp;--- Device Configuration =
---</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;Power-On Test Devices:</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp; 000&nbsp; Disabled&nbsp; System =
Memory=20
[RAM]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT =
color=3D#ff0000>&nbsp;----------------------------</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;Boot Sources:</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp; 001&nbsp; Disabled&nbsp; =
Application in=20
Flash [FLASH]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp; 002&nbsp; Enabled&nbsp;&nbsp; =
Ethernet=20
[ENET]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT=20
color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
local=3D192.168.18.28&nbsp; remote=3D192.168.18.101&nbsp;=20
hwaddr=3Dbad0add00000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp; 003&nbsp; Disabled&nbsp; Serial =
Port 1=20
[S1]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT=20
color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Baud =3D 9600</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT =
color=3D#ff0000>&nbsp;----------------------------</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Update Flash&nbsp; : Disabled </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Automatic Boot: Disabled</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT =
color=3D#ff0000>&nbsp;----------------------------</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 1 - Toggle Power-On Tests</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 2 - Change a Boot Device</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 3 - Change IP Addresses</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 4 - Ping test</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 5 - Change Baud Rate for S1 =
Boot</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 6 - Toggle Update Flash</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 7 - Toggle Automatic Boot</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; B - Bootlogo Management</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; D - Display Configuration</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; S - Save Changes</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; Z - Set Ethernet HW =
Address</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; 0 - Exit Menu and Boot =
Application</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp; C - Enable CHOIS Debug </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>-&gt;0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DM900 : dmfe_init_dm9000 : initialising=20
dm9000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Booting from [ENET] Ethernet...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Sending bootp request ...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;bootp packets sent =3D 1<BR>DM900 : =
dmfe_send :=20
hold frame collision, outbound frame.</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>Got bootp response from :=20
192.168.18.101</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My ip =
address is :=20
192.168.18.28</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>Loading file "zImage.treeboot" by TFTP =
for net boot=20
...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;block&nbsp; 268<BR>&nbsp;block =
1440<BR>Transfer=20
completed, 897568 bytes received</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Loaded successfully ...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Entry point at 0x500000 ...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; =
00500000=20
005DC164</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>relocated to:&nbsp; 00400000 =
004DC164</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>board data at: 004DA124 004DA164</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>relocated to:&nbsp; 0040515C =
0040519C</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 0040591D=20
004D9A6C</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 004DD000=20
02000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>Linux/PPC load: ip=3Don</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Uncompressing Linux...done.</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Now booting the kernel</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Linux version 2.6.14 (</FONT><A=20
href=3D"mailto:root@localhost.localdomain"><FONT=20
color=3D#ff0000>root@localhost.localdomain</FONT></A><FONT =
color=3D#ff0000>) (gcc=20
version 4.0.0 (DENX ELDK 4.0 4.0.0)) #258 Wed Sep 13 16:12:58 IST=20
2006</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_early_init()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_add_one_device()...done</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_early_init()... done.</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IBM Redwood6 (STBx25XX) Platform</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Port by MontaVista Software, Inc. (</FONT><A=20
href=3D"mailto:source@mvista.com"><FONT=20
color=3D#ff0000>source@mvista.com</FONT></A><FONT =
color=3D#ff0000>)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Built 1 zonelists</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Kernel command line: ip=3Don</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>PID hash table entries: 256 (order: 8, 4096=20
bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Dentry cache hash table entries: 8192 (order: =
3, 32768=20
bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Inode-cache hash table entries: 4096 (order: =
2, 16384=20
bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Memory: 30488k available (1452k kernel code, =
344k data,=20
96k init, 0k highmem)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Mount-cache hash table entries: =
512</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>NET: Registered protocol family =
16</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_driver_init()...</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp: ocp_driver_init()... done.</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Adding platform devices </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Serial: 8250/16550 driver $Revision: 1.90 $ 4 =
ports,=20
IRQ sharing disabled</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ttyS0 at MMIO 0x0 (irq =3D 22) is a =
16550A</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ttyS1 at MMIO 0x0 (irq =3D 20) is a =
16550A</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ttyS2 at MMIO 0x0 (irq =3D 21) is a =
16550A</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>io scheduler noop registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>io scheduler anticipatory =
registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>io scheduler deadline registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>io scheduler cfq registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>RAMDISK driver initialized: 16 RAM disks of =
4096K size=20
1024 blocksize</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>loop: loaded (max 8 devices)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>dm9000 Ethernet Driver</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>dm9000_set_io : byte_width 2</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>eth0: dm9000 at c3000000,c3000004 IRQ 26 MAC: =

ba:d0:ad:d0:00:00</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Uniform Multi-Platform E-IDE driver Revision: =

7.00alpha2</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: Assuming 50MHz system bus speed for PIO =
modes;=20
override with idebus=3Dxx</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>NET: Registered protocol family =
2</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IP route cache hash table entries: 512 =
(order: -1, 2048=20
bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>TCP established hash table entries: 2048 =
(order: 1,=20
8192 bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>TCP bind hash table entries: 2048 (order: 1, =
8192=20
bytes)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>TCP: Hash tables configured (established 2048 =
bind=20
2048)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>TCP reno registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>TCP bic registered</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>NET: Registered protocol family =
1</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>inside stb04xxx_ide_init </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IBM STB025xx OCP IDE driver version 1.0 =
f2100000=20
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_redwood: waiting for drive =
ready......Drive spun up=20
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp_ide_setup_dma </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>probing for hda: present=3D0, media=3D32,=20
probetype=3DATA</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: probing with STATUS(0x51) instead of=20
ALTSTATUS(0x00)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: WDC WD400EB-00CPF0, ATA DISK =
drive</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>probing for hdb: present=3D0, media=3D32,=20
probetype=3DATA</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>probing for hdb: present=3D0, media=3D32,=20
probetype=3DATAPI</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hdb: probing with STATUS(0x01) instead of=20
ALTSTATUS(0x00)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp_ide_tune_drive pio 4</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_off_quietly</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_check</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>redwood_config_drive_for_dma 22</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ocp_ide_tune_drive pio 4</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_on</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide0 at 0xc3004000-0xc3004007,0xc3006000 on =
irq=20
27</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: max request size: 128KiB</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x91</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x10</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xf8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: 78165360 sectors (40020 MB) w/2048KiB =
Cache,=20
CHS=3D65535/16/63, (U)DMA</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: cache flushes not supported</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;hda:__ide_do_rw_disk : dma 1 lba48 0=20
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c0340000 340000 count 8 dmastat =
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_test_irq</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 50</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 0 500000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;hda1</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IDE probe finished </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>eth0: link up, 100Mbps, full-duplex, lpa=20
0x41E1</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Sending BOOTP and RARP requests . =
OK</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IP-Config: Got BOOTP answer from =
192.168.18.101, my=20
address is 192.168.18.28</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>IP-Config: Complete:</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, =

addr=3D192.168.18.28, mask=3D255.255.255.0, =
gw=3D192.168.18.1,</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp; =
host=3D192.168.18.28, domain=3D,=20
nis-domain=3D(none),</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;&nbsp;&nbsp;&nbsp; =
bootserver=3D192.168.18.101,=20
rootserver=3D192.168.18.101, rootpath=3D/opt/eldk/ppc_4xx</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Looking up port of RPC 100003/2 on=20
192.168.18.101</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Looking up port of RPC 100005/1 on=20
192.168.18.101</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>VFS: Mounted root (nfs filesystem)=20
readonly.</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Freeing unused kernel memory: 96k =
init</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>modprobe: FATAL: Could not load=20
/lib/modules/2.6.14/modules.dep: No such file or directory</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>modprobe: FATAL: Could not load=20
/lib/modules/2.6.14/modules.dep: No such file or directory</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#ff0000>INIT: version 2.85 booting<BR>&nbsp;Came =
here in=20
rc.sysinit creating var\n<BR>mounting <BR>ln: `/proc/mounts': File=20
exists<BR>&nbsp;&nbsp;Welcome to DENX Embedded Linux=20
Environment<BR>&nbsp;&nbsp;Press 'I' to enter interactive =
startup.<BR>Building=20
the cache [&nbsp; OK&nbsp; ]<BR>&nbsp;storage network audio done[&nbsp; =
OK&nbsp;=20
]<BR>modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No =
such=20
file or directory</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Cannot access the Hardware Clock via any =
known=20
method.<BR>Use the --debug option to see the details of our search for =
an access=20
method.<BR>Setting clock : Thu Jan&nbsp; 1 01:00:12 MET 1970 [&nbsp; =
OK&nbsp;=20
]<BR>Setting hostname CHOISpad-110:&nbsp; [&nbsp; OK&nbsp; ]<BR>Mounting =
local=20
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<BR>Enabling swap space:&nbsp; =
[&nbsp;=20
OK&nbsp; ]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>INIT: Entering runlevel: 3<BR>Entering =
non-interactive=20
startup<BR>Bringing up loopback interface:&nbsp; modprobe: FATAL: Could =
not load=20
/lib/modules/2.6.14/modules.dep: No such file or directory</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>arping: socket: Address family not supported =
by=20
protocol<BR>Error, some other host already uses address=20
127.0.0.1.<BR>[FAILED]<BR>Starting system logger: [&nbsp; OK&nbsp; =
]<BR>Starting=20
kernel logger: [&nbsp; OK&nbsp; ]<BR>Starting portmap: [&nbsp; OK&nbsp;=20
]<BR>Mounting NFS filesystems:&nbsp; [&nbsp; OK&nbsp; ]<BR>Mounting =
other=20
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<BR>Starting xinetd: [&nbsp; =
OK&nbsp;=20
]</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DENX ELDK version 4.0 build =
2006-01-11<BR>Linux 2.6.14=20
on a ppc</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>CHOISpad-110 login: root<BR>Last login: Thu =
Jan&nbsp; 1=20
01:00:19 on console<BR>bash-3.00# <BR>bash-3.00# <BR>bash-3.00# =
<BR>bash-3.00#=20
<BR>bash-3.00# <BR>bash-3.00# hdparm -t=08 =08=08 =
=08/dev/hda</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT =
color=3D#ff0000>/dev/hda:<BR>&nbsp;multcount&nbsp;&nbsp;&nbsp; =3D&nbsp; =

0 (off)<BR>&nbsp;I/O support&nbsp; =3D&nbsp; 0 (default=20
16-bit)<BR>&nbsp;unmaskirq&nbsp;&nbsp;&nbsp; =3D&nbsp; 1=20
(on)<BR>&nbsp;using_dma&nbsp;&nbsp;&nbsp; =3D&nbsp; 1 =
(on)<BR>&nbsp;keepsettings=20
=3D&nbsp; 0 (off)<BR>&nbsp;nowerr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D&nbsp; 0=20
(off)<BR>&nbsp;readonly&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp; 0=20
(off)<BR>&nbsp;readahead&nbsp;&nbsp;&nbsp; =3D 256=20
(on)<BR>&nbsp;geometry&nbsp;&nbsp;&nbsp;&nbsp; =3D 65535/16/63, sectors =
=3D=20
78165360, start =3D 0<BR>bash-3.00# <BR>bash-3.00# <BR>bash-3.00# =
<BR>bash-3.00#=20
<BR>bash-3.00# hdparm -t /dev/hda</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>/dev/hda:<BR>&nbsp;Timing =
buffered__ide_do_rw_disk :=20
dma 1 lba48 0 LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>&nbsp;disk reads:&nbsp; got ocp_ide_dma_setup =

</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x10</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_off_quietly</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide0: reset: master: error =
(0x00?)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x91</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x10</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0x10</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>__ide_do_rw_disk : dma 1 lba48 0 =
LBA=3D0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_setup </FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_execute_command : 0xc8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_begin 0x1000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA addr c1238000 1238000 count 8 dmastat=20
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>DMA complete stat 20001000 0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: lost interrupt</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_end 0 20000000</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide_dma_intr : stat 58</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>hda: dma_intr: status=3D0x58 { DriveReady =
SeekComplete=20
DataRequest }</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide: failed opcode was: unknown</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>got ocp_ide_dma_off_quietly</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>ide0: reset: master: error =
(0x00?)</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

1</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
16</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

2</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
24</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

3</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
32</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

4</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
40</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

5</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
48</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

6</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
56</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

7</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
64</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

8</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
72</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>Buffer I/O error on device hda, logical block =

9</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
80</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
88</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
96</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
104</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
112</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
120</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
128</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
136</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
144</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
152</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
160</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
168</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
176</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
184</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
192</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
200</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
208</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
216</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
224</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
232</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
240</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
248</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
256</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
264</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
272</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
280</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
288</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
296</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
304</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
312</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
320</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
328</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
336</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
344</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
352</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
360</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
368</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
376</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
384</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
392</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
400</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
408</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
416</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
424</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
432</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
440</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
448</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
456</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
464</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
472</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
480</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
488</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
496</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector=20
504</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>end_request: I/O error, dev hda, sector =
0</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000>read() failed: Input/output =
error<BR>bash-3.00#=20
</FONT></DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#ff0000></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000080>static void ocp_ide_dma_begin(ide_drive_t=20
*drive){<BR>int i,reading=3D0,length;<BR>struct request * const rq =3D=20
HWGROUP(drive)-&gt;rq;<BR>unsigned long control;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;if(rq_data_dir (rq) =3D=3D READ) =
reading =3D=20
1;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk("got ocp_ide_dma_begin=20
0x%x\n",mfdcr(DCRN_DMASR));<BR>&nbsp;/* enable DMA=20
*/<BR>&nbsp;ppc4xx_enable_dma_interrupt(IDE_DMACH);<BR>&nbsp;/*dmastat =
=3D=20
mfdcr(DCRN_DMASR);<BR>&nbsp;mtdcr(DCRN_DMASR,((u32)DMA_CH2_ERR | =
(u32)DMA_CS2 |=20
(u32)DMA_TS2));<BR>&nbsp;*/<BR>&nbsp;mtdcr(DCRN_DMASR,0x22200120);<BR>&nb=
sp;/*Configure=20
CIC reg for line mode DMA*/<BR>#ifdef=20
WMODE<BR>&nbsp;mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) |=20
0x00000400));<BR>#else<BR>&nbsp;mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) =
&amp;=20
~0x00000400));</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>#endif</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;if(drive-&gt;media !=3D ide_disk)=20
{<BR>&nbsp;&nbsp;printk("ocp_ide_dma_begin : Invalid media=20
\n");<BR>&nbsp;&nbsp;return;<BR>&nbsp;}<BR>&nbsp;if(ppc4xx_get_channel_co=
nfig(IDE_DMACH,&amp;dma_ch)=20
&amp; DMA_CHANNEL_BUSY){<BR>&nbsp;&nbsp;&nbsp;printk("DMA channel busy=20
\n");<BR>&nbsp;&nbsp;&nbsp;return;<BR>&nbsp;}<BR>&nbsp;memset(rq-&gt;buff=
er,0,rq-&gt;current_nr_sectors*512);<BR>&nbsp;if(reading){<BR>&nbsp;&nbsp=
;<BR>&nbsp;&nbsp;dma_cache_inv((unsigned=20
long) rq-&gt;buffer, rq-&gt;current_nr_sectors * 512);<BR>#ifdef=20
WMODE<BR>&nbsp;&nbsp;mtdcr(DCRN_DMASA2,(u32)0x00000000);// set src =
address for=20
DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq-&gt;buffer));//set=
 dst=20
address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DCRXBCR,0x00000000);<BR>&nbsp;&nbsp;control =
=3D=20
0xE600CB02;<BR>#else<BR>&nbsp;&nbsp;mtdcr(DCRN_DMASA2,(u32)0xfce00000);//=
 set=20
src address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq-&gt;buffer));//set=
 dst=20
address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DCRXBCR,0x90000000);<BR>&nbsp;&nbsp;control =
=3D=20
0xEE602b02;<BR>#endif<BR>&nbsp;}<BR>&nbsp;else=20
{<BR>&nbsp;&nbsp;dma_cache_wback_inv((unsigned long) rq-&gt;buffer,=20
rq-&gt;current_nr_sectors * 512);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>#ifdef=20
WMODE<BR>&nbsp;&nbsp;mtdcr(DCRN_DMASA2,(u32)0x00000000);// set dst =
address for=20
DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DMADA2,(u32)virt_to_bus(rq-&gt;buffer));// =
set src=20
address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DCRXBCR,0x00000000);<BR>&nbsp;&nbsp;control =
=3D=20
0xC600CB02;<BR>#else<BR>&nbsp;&nbsp;mtdcr(DCRN_DMADA2,(u32)0xfce00000);//=
 set=20
dst address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DMASA2,(u32)virt_to_bus(rq-&gt;buffer));// =
set src=20
address for DMA channel=20
2<BR>&nbsp;&nbsp;mtdcr(DCRN_DCRXBCR,0xB0000000);<BR>&nbsp;&nbsp;control =
=3D=20
0xcd602b02;<BR>#endif</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;}</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>#ifdef WMODE<BR>&nbsp;length =3D=20
(rq-&gt;current_nr_sectors *512)/2;<BR>#else<BR>&nbsp;length =3D=20
(rq-&gt;current_nr_sectors=20
*512)/16;<BR>#endif<BR>&nbsp;mtdcr(DCRN_DMACT2,length);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;/*control =3D =
mfdcr(DCRN_DMACR2);<BR>&nbsp;control=20
|=3D DMA_CIE_ENABLE;&nbsp; Channel Interrupt Enable =
<BR>&nbsp;*/<BR>&nbsp;control=20
&amp;=3D ~DMA_CIE_ENABLE;<BR>&nbsp;mtdcr(DCRN_DMACR2,=20
control);<BR>&nbsp;//ppc4xx_enable_dma_interrupt(IDE_DMACH);<BR>&nbsp;<BR=
>&nbsp;printk("DMA=20
addr %x %x count %d dmastat=20
%x\n",rq-&gt;buffer,virt_to_bus(rq-&gt;buffer),rq-&gt;current_nr_sectors,=
dmastat);<BR>&nbsp;/*=20
wait for dma to complete (channel 2 terminal count) */<BR>&nbsp;for (i =
=3D 0; i=20
&lt; 500000; i++) {<BR>&nbsp;&nbsp;if(i%1000 =3D=3D =
0)<BR>&nbsp;&nbsp;&nbsp;dmastat=20
=3D mfdcr(DCRN_DMASR);<BR>&nbsp;&nbsp;if (dmastat &amp;=20
DMA_CS2)<BR>&nbsp;&nbsp;&nbsp;break;<BR>&nbsp;}<BR>&nbsp;printk("DMA =
complete=20
stat %x=20
%d\n",dmastat,i);<BR>&nbsp;mtdcr(DCRN_DCRXBCR,0x00000000);<BR>&nbsp;mtdcr=
(DCRN_DMACR2,=20
0x00000000);<BR>&nbsp;drive-&gt;waiting_for_dma =3D =
0;<BR>&nbsp;//dmastat =3D=20
0;<BR>}<BR>static int ocp_ide_dma_end(ide_drive_t *drive){<BR>unsigned =
int tmp =3D=20
mfdcr(DCRN_DMASR);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;mtdcr (DCRN_UIC_SR(UIC0),(0x80000000ul =
&gt;&gt;=20
IDE_DMA_INT));<BR>&nbsp;mtdcr(DCRN_DMASR,0x22200120);<BR>&nbsp;dmastat =
=3D=20
mfdcr(DCRN_DMASR);<BR>&nbsp;printk("got ocp_ide_dma_end %x=20
%x\n",dmastat,tmp);<BR>&nbsp;drive-&gt;waiting_for_dma =3D =
0;<BR>&nbsp;/* disable=20
DMA */<BR>&nbsp;//ppc4xx_disable_dma_interrupt(IDE_DMACH);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;return 0;<BR>}</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>static void<BR>ocp_ide_setup_dma (ide_hwif_t =
* const=20
hwif)<BR>{<BR>&nbsp;printk("ocp_ide_setup_dma \n");</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#000080>&nbsp;hwif-&gt;dma =3D =
IDE_DMACH;<BR>#ifdef=20
WMODE<BR>&nbsp;&nbsp; /*Word Mode psc(11-12)=3D00,pwc(13-18)=3D000110,=20
phc(19-21)=3D010, 22=3D1, 30=3D1&nbsp; ----&nbsp; 0xCB02*/</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT =
color=3D#000080>&nbsp;dma_ch.mode&nbsp;=3DTM_S_MM;&nbsp;&nbsp; /* xfer=20
from peripheral to mem */<BR>&nbsp;dma_ch.td&nbsp;=3D=20
DMA_TD;<BR>&nbsp;dma_ch.buffer_enable =3D =
FALSE;<BR>&nbsp;dma_ch.tce_enable =3D=20
FALSE;<BR>&nbsp;dma_ch.etd_output =3D FALSE;<BR>&nbsp;dma_ch.pce =3D=20
FALSE;<BR>&nbsp;dma_ch.pl =3D EXTERNAL_PERIPHERAL;&nbsp;&nbsp;&nbsp; /* =
no op=20
*/<BR>&nbsp;dma_ch.pwidth =3D PW_16;<BR>&nbsp;dma_ch.dai =3D=20
TRUE;<BR>&nbsp;dma_ch.sai =3D FALSE;<BR>&nbsp;dma_ch.psc =3D=20
0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max setup cycles */<BR>&nbsp;dma_ch.pwc =3D=20
6;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max wait cycles&nbsp; */<BR>&nbsp;dma_ch.phc =3D=20
2;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max hold cycles&nbsp; */<BR>&nbsp;dma_ch.cp =3D=20
PRIORITY_LOW;<BR>&nbsp;dma_ch.int_enable =3D =
FALSE;<BR>&nbsp;dma_ch.ch_enable =3D=20
FALSE;&nbsp;&nbsp;/* No chaining */<BR>&nbsp;dma_ch.tcd_disable =3D=20
TRUE;&nbsp;&nbsp;/* No chaining */<BR>#else<BR>/*Line Mode=20
psc(11-12)=3D00,pwc(13-18)=3D000001, phc(19-21)=3D010, 22=3D1, =
30=3D1&nbsp; ----&nbsp;=20
0x2B02*/</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT=20
color=3D#000080>&nbsp;dma_ch.mode&nbsp;=3DDMA_MODE_MM_DEVATSRC;&nbsp;&nbs=
p; /* xfer=20
from peripheral to mem */<BR>&nbsp;dma_ch.td&nbsp;=3D=20
DMA_TD;<BR>&nbsp;dma_ch.buffer_enable =3D =
FALSE;<BR>&nbsp;dma_ch.tce_enable =3D=20
FALSE;<BR>&nbsp;dma_ch.etd_output =3D FALSE;<BR>&nbsp;dma_ch.pce =3D=20
FALSE;<BR>&nbsp;dma_ch.pl =3D EXTERNAL_PERIPHERAL;&nbsp;&nbsp;&nbsp; /* =
no op=20
*/<BR>&nbsp;dma_ch.pwidth =3D PW_64;&nbsp;&nbsp;/* Line mode on stbs=20
*/<BR>&nbsp;dma_ch.dai =3D TRUE;<BR>&nbsp;dma_ch.sai =3D =
FALSE;<BR>&nbsp;dma_ch.psc=20
=3D=20
0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max setup cycles */<BR>&nbsp;dma_ch.pwc =3D=20
1;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max wait cycles&nbsp; */<BR>&nbsp;dma_ch.phc =3D=20
2;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* set the max hold cycles&nbsp; */<BR>&nbsp;dma_ch.cp =3D=20
PRIORITY_LOW;<BR>&nbsp;dma_ch.int_enable =3D =
FALSE;<BR>&nbsp;dma_ch.ch_enable =3D=20
FALSE;&nbsp;&nbsp;/* No chaining */<BR>&nbsp;dma_ch.tcd_disable =3D=20
TRUE;&nbsp;&nbsp;/* No chaining */</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>#endif<BR>&nbsp;if =
(ppc4xx_init_dma_channel(IDE_DMACH,=20
&amp;dma_ch) !=3D =
DMA_STATUS_GOOD){<BR>&nbsp;&nbsp;printk("ppc4xx_init_dma_channel=20
failed\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;return=20
-EBUSY;<BR>&nbsp;}<BR>&nbsp;//ppc4xx_disable_dma_interrupt(IDE_DMACH);</F=
ONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;/*init CIC control register to enable =
IDE=20
interface PIO mode*/<BR>&nbsp;mtdcr(DCRN_CICCR,(mfdcr(DCRN_CICCR) &amp;=20
0xffff7bff) | 0x00000003);<BR>&nbsp;mtdcr(DCRN_DMACR2,=20
0);<BR>&nbsp;ppc4xx_clr_dma_status(IDE_DMACH);<BR>&nbsp;/* init CIC =
select2 reg=20
to connect external DMA port 3 to internal<BR>&nbsp; * DMA channel=20
2</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp; =
*/<BR>&nbsp;mtdcr(DCRN_DMAS2,(mfdcr(DCRN_DMAS2)=20
&amp; 0xfffffff0) | 0x00000002);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#000080>&nbsp;hwif-&gt;autodma =3D=20
1;hwif-&gt;udma_four=3D0;<BR>&nbsp;hwif-&gt;drives[0].autotune =3D=20
hwif-&gt;drives[1].autotune =3D=20
IDE_TUNE_AUTO;<BR>&nbsp;hwif-&gt;drives[0].autodma&nbsp; =3D=20
hwif-&gt;drives[1].autodma&nbsp; =3D hwif-&gt;autodma;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;hwif-&gt;atapi_dma&nbsp; =3D=20
0;<BR>&nbsp;hwif-&gt;ultra_mask =3D hwif-&gt;udma_four ? 0x1f :=20
0x07;<BR>&nbsp;hwif-&gt;mwdma_mask =3D =
0x07;<BR>&nbsp;hwif-&gt;swdma_mask =3D=20
0x00;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;/* set everything to something !=3D =
NULL=20
*/<BR>&nbsp;hwif-&gt;ide_dma_host_off&nbsp;&nbsp; =3D=20
&amp;ocp_ide_dma_off_quietly;<BR>&nbsp;hwif-&gt;ide_dma_host_on&nbsp;=20
&nbsp;&nbsp; =3D &amp;ocp_ide_dma_on;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;hwif-&gt;ide_dma_check&nbsp;&nbsp; =3D=20
&amp;ocp_ide_dma_check;<BR>&nbsp;hwif-&gt;ide_dma_off_quietly &nbsp; =3D =

&amp;ocp_ide_dma_off_quietly;<BR>&nbsp;hwif-&gt;ide_dma_on&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp; =3D &amp;ocp_ide_dma_on;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;hwif-&gt;dma_setup&nbsp;&nbsp; =
&nbsp;&nbsp; =3D=20
&amp;ocp_ide_dma_setup;<BR>&nbsp;hwif-&gt;dma_exec_cmd &nbsp;&nbsp; =3D=20
&amp;ocp_dma_exec_cmd;<BR>&nbsp;hwif-&gt;dma_start&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp; =3D &amp;ocp_ide_dma_begin;<BR>&nbsp;hwif-&gt;ide_dma_end=20
&nbsp;&nbsp; =3D &amp;ocp_ide_dma_end;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;hwif-&gt;ide_dma_test_irq&nbsp;&nbsp; =
=3D=20
&amp;ocp_ide_dma_test_irq;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;hwif-&gt;ide_dma_lostirq &nbsp;&nbsp; =
=3D=20
&amp;ocp_ide_dma_lostirq;<BR>&nbsp;hwif-&gt;ide_dma_timeout &nbsp;&nbsp; =
=3D=20
&amp;ocp_ide_dma_timeout;<BR>}<BR>&nbsp;&nbsp;<BR>static int=20
__init<BR>stb025xx_ide_probe (struct ocp_device * const=20
ocp)<BR>{<BR>&nbsp;int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
err;<BR>&nbsp;unsigned=20
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
uicdcr;<BR>&nbsp;volatile unsigned long&nbsp;ide_regs;<BR>&nbsp;unsigned =

long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
flags,ioaddr;<BR>&nbsp;ide_hwif_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
* const hwif =3D &amp;ide_hwifs[0];<BR>&nbsp;unsigned=20
char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=20
ip;<BR>&nbsp;int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
i;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk ("IBM STB025xx OCP IDE driver =
version %s=20
%x \n", IDEVR,ocp-&gt;def-&gt;paddr);<BR>&nbsp;if=20
(!request_region(REDWOOD_IDE_CMD, 0x10, "IDE"))<BR>&nbsp;&nbsp;return=20
-EBUSY;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;if (!request_region(REDWOOD_IDE_CTRL, =
2, "IDE"))=20
{<BR>&nbsp;&nbsp;release_region(REDWOOD_IDE_CMD, =
0x10);<BR>&nbsp;&nbsp;return=20
-EBUSY;<BR>&nbsp;}</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;ide_regs =3D ioaddr =3D (unsigned long) =

ioremap(REDWOOD_IDE_CMD, 0x10);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;for (i =3D IDE_DATA_OFFSET; i &lt;=3D=20
IDE_STATUS_OFFSET; i++) {<BR>&nbsp;&nbsp;hwif-&gt;io_ports[i] =3D=20
ioaddr;<BR>&nbsp;&nbsp;ioaddr +=3D=20
2;<BR>&nbsp;}<BR>&nbsp;hwif-&gt;io_ports[IDE_CONTROL_OFFSET]=20
=3D<BR>&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long) =
ioremap(REDWOOD_IDE_CTRL,=20
2);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;ocp_force_power_on =
(ocp);<BR>&nbsp;<BR>&nbsp;/*=20
initialize */<BR>&nbsp;hwif-&gt;gendev.parent =3D=20
&amp;ocp-&gt;dev;<BR>&nbsp;ocp_set_drvdata (ocp, hwif);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;/* setup MMIO ops =
*/<BR>&nbsp;default_hwif_mmiops=20
(hwif);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;/* tell common code _not_ to mess with =
resources=20
*/<BR>&nbsp;hwif-&gt;mmio =3D 2;<BR>&nbsp;ide_set_hwifdata (hwif, (void =
*)=20
ide_regs);<BR>&nbsp;<BR>&nbsp;hwif-&gt;chipset =3D=20
ide_generic;<BR>&nbsp;hwif-&gt;irq&nbsp;&nbsp;&nbsp;&nbsp; =3D=20
IDE0_IRQ;<BR>&nbsp;hwif-&gt;noprobe =3D=20
0;<BR>&nbsp;hwif-&gt;hold&nbsp;&nbsp;&nbsp; =3D =
1;<BR>&nbsp;hwif-&gt;udma_four =3D=20
0;<BR>&nbsp;hwif-&gt;tuneproc&nbsp; =3D=20
&amp;ocp_ide_tune_drive;<BR>&nbsp;hwif-&gt;speedproc =3D=20
&amp;ocp_ide_tune_chipset;<BR>&nbsp;hwif-&gt;drives[0].io_32bit =3D=20
hwif-&gt;drives[1].io_32bit =3D =
0;<BR>&nbsp;hwif-&gt;drives[0].unmask&nbsp;&nbsp;=20
=3D hwif-&gt;drives[1].unmask&nbsp;&nbsp; =3D 1;<BR>&nbsp;pio_mode[0] =
=3D pio_mode[1]=20
=3D =
-1;<BR>&nbsp;<BR>&nbsp;ibm25xx_ide_spinup(0);<BR>&nbsp;ocp_ide_setup_dma =

(hwif);<BR>&nbsp;probe_hwif_init (hwif);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;create_proc_ide_interfaces=20
();<BR>&nbsp;printk("IDE probe finished \n");<BR>&nbsp;return =
0;<BR>}<BR>static=20
int ocp_ide_dma_end(ide_drive_t *drive){<BR>unsigned int tmp =3D=20
mfdcr(DCRN_DMASR);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;mtdcr (DCRN_UIC_SR(UIC0),(0x80000000ul =
&gt;&gt;=20
IDE_DMA_INT));<BR>&nbsp;mtdcr(DCRN_DMASR,0x22200120);<BR>&nbsp;dmastat =
=3D=20
mfdcr(DCRN_DMASR);<BR>&nbsp;printk("got ocp_ide_dma_end %x=20
%x\n",dmastat,tmp);<BR>&nbsp;drive-&gt;waiting_for_dma =3D =
0;<BR>&nbsp;/* disable=20
DMA */<BR>&nbsp;//ppc4xx_disable_dma_interrupt(IDE_DMACH);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;return 0;<BR>}<BR>static int=20
ocp_ide_dma_test_irq(ide_drive_t *drive){</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk("got=20
ocp_ide_dma_test_irq\n");<BR>&nbsp;return 1;&nbsp;/* returns 1 if dma =
irq=20
issued, 0 otherwise */<BR>}<BR>static int =
ocp_ide_dma_verbose(ide_drive_t=20
*drive){</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk("got=20
ocp_ide_dma_verbose\n");<BR>&nbsp;return 1;<BR>}<BR>static int=20
ocp_ide_dma_lostirq(ide_drive_t *drive){</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><BR><FONT color=3D#000080>&nbsp;printk("got=20
ocp_ide_dma_lostirq\n");<BR>&nbsp;return 1;<BR>}<BR>static int=20
ocp_ide_dma_timeout(ide_drive_t *drive){</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk("got=20
ocp_ide_dma_timeout\n");<BR>&nbsp;return 1;<BR>}<BR>static=20
void<BR>ocp_dma_exec_cmd (ide_drive_t * const drive, u8 =
command){<BR>ide_hwif_t=20
*hwif =3D HWIF(drive);</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;//hwif-&gt;OUTBSYNC(drive,command,=20
IDE_COMMAND_REG);<BR>&nbsp;//printk("ide_dma_exec_cmd=20
%x\n",command);<BR>&nbsp;ide_execute_command (drive, =
command,&amp;ide_dma_intr,=20
2*WAIT_CMD, NULL);<BR>}<BR>static int ocp_ide_dma_setup(ide_drive_t * =
const=20
drive){<BR>&nbsp;ide_hwif_t &nbsp;* const hwif =3D =
HWIF(drive);<BR>&nbsp;struct=20
request * const rq =3D HWGROUP(drive)-&gt;rq;</FONT></DIV>
<DIV><FONT color=3D#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#000080>&nbsp;printk("got ocp_ide_dma_setup=20
\n");<BR>&nbsp;/*if(rq-&gt;current_nr_sectors &lt;=20
2){<BR>&nbsp;&nbsp;printk("request for less no of sectors=20
%d\n",rq-&gt;current_nr_sectors);<BR>&nbsp;&nbsp;ide_map_sg(drive,rq);dri=
ve-&gt;waiting_for_dma=3D0;=20
<BR>&nbsp;&nbsp;return =
1;<BR>&nbsp;}*/<BR>&nbsp;drive-&gt;waiting_for_dma =3D=20
1;<BR>&nbsp;return =
0;<BR>}&nbsp;<BR></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_014B_01C6D8B2.F890B810--
