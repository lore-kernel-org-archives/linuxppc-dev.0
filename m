Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (unknown [220.227.188.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E99167B67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 21:11:31 +1000 (EST)
Received: from tambethinkpad ([192.168.28.2]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.12.11/8.12.11) with ESMTP id
	k8DBBO9c002412
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Sep 2006 16:41:24 +0530
Message-ID: <002301c6d725$553a8c60$021ca8c0@tambethinkpad>
From: "Akhilesh" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: IDE DMA Issue ppc
Date: Wed, 13 Sep 2006 16:41:16 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C6D753.6EC1CD50"
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

------=_NextPart_000_001F_01C6D753.6EC1CD50
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0020_01C6D753.6EC1CD50"


------=_NextPart_001_0020_01C6D753.6EC1CD50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,


I'm using IBM redwood6 stb025xx(ppc405gp) platform with 2.6.14 kernel. =
I'm trying to get DMA working for IDE interface (PIO is working). The =
problem I'm facing is that my DMA is completing and I'm getting a error =
in DMA status register that "A DMA  request from an external device is =
pending"

I'm attaching the console message along with the sample code of the =
driver. Please help me to resolve this issue. What I feel is that DMA is =
completing and IDE is not getting anything. ( IDE status register is =
giving 0x58).

Any pointers to same will be highly appreciated.


Regards,
Akhilesh

------=_NextPart_001_0020_01C6D753.6EC1CD50
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
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
<DIV><FONT face=3DArial size=3D2>I'm attaching the console message along =
with the=20
sample code of the driver. Please help me to resolve this issue. What I =
feel is=20
that DMA is completing and IDE is not getting anything. ( IDE status =
register is=20
giving 0x58).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any pointers to same will be highly=20
appreciated.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_001_0020_01C6D753.6EC1CD50--

------=_NextPart_000_001F_01C6D753.6EC1CD50
Content-Type: text/plain;
	name="console.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="console.txt"

=0A=
=0A=
IBM Set-Top-Box BIOS 1.50 (Feb-16-2004)=0A=
=0A=
Platform support <Redwood6/STBx25xx 1.03 (Jun/24/2002)>=0A=
=0A=
=0A=
Initializing devices, please wait.....=0A=
                                         =0A=
=0A=
 ------- System Info --------=0A=
=0A=
 Processor speed =3D 252 MHz=0A=
=0A=
 EBIU speed      =3D 63 MHz=0A=
=0A=
 Amount of RAM   =3D 64 MBytes=0A=
=0A=
DM9000 : dmfe_probe() : Checking DM9000 chip =0A=
=0A=
DM9000 : Chip Found ID : 90000a46 =0A=
=0A=
=0A=
 --- Device Configuration ---=0A=
=0A=
 Power-On Test Devices:=0A=
=0A=
   000  Disabled  System Memory [RAM]=0A=
=0A=
 ----------------------------=0A=
=0A=
 Boot Sources:=0A=
=0A=
   001  Disabled  Application in Flash [FLASH]=0A=
=0A=
   002  Enabled   Ethernet [ENET]=0A=
=0A=
                  local=3D192.168.18.28  remote=3D192.168.18.101  =
hwaddr=3Dbad0add00000=0A=
=0A=
   003  Disabled  Serial Port 1 [S1]=0A=
=0A=
                  Baud =3D 9600=0A=
=0A=
 ----------------------------=0A=
=0A=
Update Flash  : Disabled =0A=
=0A=
Automatic Boot: Disabled=0A=
=0A=
 ----------------------------=0A=
=0A=
  1 - Toggle Power-On Tests=0A=
=0A=
  2 - Change a Boot Device=0A=
=0A=
  3 - Change IP Addresses=0A=
=0A=
  4 - Ping test=0A=
=0A=
  5 - Change Baud Rate for S1 Boot=0A=
=0A=
  6 - Toggle Update Flash=0A=
=0A=
  7 - Toggle Automatic Boot=0A=
=0A=
  B - Bootlogo Management=0A=
=0A=
  D - Display Configuration=0A=
=0A=
  S - Save Changes=0A=
=0A=
  Z - Set Ethernet HW Address=0A=
=0A=
  0 - Exit Menu and Boot Application=0A=
=0A=
  C - Enable CHOIS Debug =0A=
=0A=
->0=0A=
=0A=
DM900 : dmfe_init_dm9000 : initialising dm9000=0A=
=0A=
Booting from [ENET] Ethernet...=0A=
=0A=
Sending bootp request ...=0A=
=0A=
 bootp packets sent =3D 1=0A=
DM900 : dmfe_send : hold frame collision, outbound frame.=0A=
=0A=
=0A=
Got bootp response from : 192.168.18.101=0A=
=0A=
       My ip address is : 192.168.18.28=0A=
=0A=
=0A=
Loading file "zImage.treeboot" by TFTP for net boot ...=0A=
=0A=
 block  268=0A=
 block 1440=0A=
Transfer completed, 897568 bytes received=0A=
=0A=
Loaded successfully ...=0A=
=0A=
Entry point at 0x500000 ...=0A=
=0A=
=0A=
loaded at:     00500000 005DC164=0A=
=0A=
relocated to:  00400000 004DC164=0A=
=0A=
board data at: 004DA124 004DA164=0A=
=0A=
relocated to:  0040515C 0040519C=0A=
=0A=
zimage at:     0040591D 004D9A6C=0A=
=0A=
avail ram:     004DD000 02000000=0A=
=0A=
=0A=
Linux/PPC load: ip=3Don=0A=
=0A=
Uncompressing Linux...done.=0A=
=0A=
Now booting the kernel=0A=
=0A=
Linux version 2.6.14 (root@localhost.localdomain) (gcc version 4.0.0 =
(DENX ELDK 4.0 4.0.0)) #258 Wed Sep 13 16:12:58 IST 2006=0A=
=0A=
ocp: ocp_early_init()...=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_add_one_device()...=0A=
=0A=
ocp: ocp_add_one_device()...done=0A=
=0A=
ocp: ocp_early_init()... done.=0A=
=0A=
IBM Redwood6 (STBx25XX) Platform=0A=
=0A=
Port by MontaVista Software, Inc. (source@mvista.com)=0A=
=0A=
Built 1 zonelists=0A=
=0A=
Kernel command line: ip=3Don=0A=
=0A=
PID hash table entries: 256 (order: 8, 4096 bytes)=0A=
=0A=
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
=0A=
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
=0A=
Memory: 30488k available (1452k kernel code, 344k data, 96k init, 0k =
highmem)=0A=
=0A=
Mount-cache hash table entries: 512=0A=
=0A=
NET: Registered protocol family 16=0A=
=0A=
ocp: ocp_driver_init()...=0A=
=0A=
ocp: ocp_driver_init()... done.=0A=
=0A=
Adding platform devices =0A=
=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled=0A=
=0A=
ttyS0 at MMIO 0x0 (irq =3D 22) is a 16550A=0A=
=0A=
ttyS1 at MMIO 0x0 (irq =3D 20) is a 16550A=0A=
=0A=
ttyS2 at MMIO 0x0 (irq =3D 21) is a 16550A=0A=
=0A=
io scheduler noop registered=0A=
=0A=
io scheduler anticipatory registered=0A=
=0A=
io scheduler deadline registered=0A=
=0A=
io scheduler cfq registered=0A=
=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
=0A=
loop: loaded (max 8 devices)=0A=
=0A=
dm9000 Ethernet Driver=0A=
=0A=
dm9000_set_io : byte_width 2=0A=
=0A=
eth0: dm9000 at c3000000,c3000004 IRQ 26 MAC: ba:d0:ad:d0:00:00=0A=
=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
=0A=
ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
=0A=
NET: Registered protocol family 2=0A=
=0A=
IP route cache hash table entries: 512 (order: -1, 2048 bytes)=0A=
=0A=
TCP established hash table entries: 2048 (order: 1, 8192 bytes)=0A=
=0A=
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)=0A=
=0A=
TCP: Hash tables configured (established 2048 bind 2048)=0A=
=0A=
TCP reno registered=0A=
=0A=
TCP bic registered=0A=
=0A=
NET: Registered protocol family 1=0A=
=0A=
inside stb04xxx_ide_init =0A=
=0A=
IBM STB025xx OCP IDE driver version 1.0 f2100000 =0A=
=0A=
ide_redwood: waiting for drive ready......Drive spun up =0A=
=0A=
ocp_ide_setup_dma =0A=
=0A=
probing for hda: present=3D0, media=3D32, probetype=3DATA=0A=
=0A=
hda: probing with STATUS(0x51) instead of ALTSTATUS(0x00)=0A=
=0A=
hda: WDC WD400EB-00CPF0, ATA DISK drive=0A=
=0A=
probing for hdb: present=3D0, media=3D32, probetype=3DATA=0A=
=0A=
probing for hdb: present=3D0, media=3D32, probetype=3DATAPI=0A=
=0A=
hdb: probing with STATUS(0x01) instead of ALTSTATUS(0x00)=0A=
=0A=
ocp_ide_tune_drive pio 4=0A=
=0A=
got ocp_ide_dma_off_quietly=0A=
=0A=
got ocp_ide_dma_check=0A=
=0A=
redwood_config_drive_for_dma 22=0A=
=0A=
ocp_ide_tune_drive pio 4=0A=
=0A=
got ocp_ide_dma_on=0A=
=0A=
ide0 at 0xc3004000-0xc3004007,0xc3006000 on irq 27=0A=
=0A=
hda: max request size: 128KiB=0A=
=0A=
ide_execute_command : 0x91=0A=
=0A=
ide_execute_command : 0x10=0A=
=0A=
ide_execute_command : 0xf8=0A=
=0A=
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63, =
(U)DMA=0A=
=0A=
hda: cache flushes not supported=0A=
=0A=
 hda:__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c0340000 340000 count 8 dmastat 0=0A=
=0A=
got ocp_ide_dma_test_irq=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 50=0A=
=0A=
DMA complete stat 0 500000=0A=
=0A=
 hda1=0A=
=0A=
IDE probe finished =0A=
=0A=
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1=0A=
=0A=
Sending BOOTP and RARP requests . OK=0A=
=0A=
IP-Config: Got BOOTP answer from 192.168.18.101, my address is =
192.168.18.28=0A=
=0A=
IP-Config: Complete:=0A=
=0A=
      device=3Deth0, addr=3D192.168.18.28, mask=3D255.255.255.0, =
gw=3D192.168.18.1,=0A=
=0A=
     host=3D192.168.18.28, domain=3D, nis-domain=3D(none),=0A=
=0A=
     bootserver=3D192.168.18.101, rootserver=3D192.168.18.101, =
rootpath=3D/opt/eldk/ppc_4xx=0A=
=0A=
Looking up port of RPC 100003/2 on 192.168.18.101=0A=
=0A=
Looking up port of RPC 100005/1 on 192.168.18.101=0A=
=0A=
VFS: Mounted root (nfs filesystem) readonly.=0A=
=0A=
Freeing unused kernel memory: 96k init=0A=
=0A=
modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory=0A=
=0A=
modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory=0A=
=0A=
=0A=
INIT: version 2.85 booting=0A=
 Came here in rc.sysinit creating var\n=0A=
mounting =0A=
ln: `/proc/mounts': File exists=0A=
		Welcome to DENX Embedded Linux Environment=0A=
		Press 'I' to enter interactive startup.=0A=
Building the cache [  OK  ]=0A=
 storage network audio done[  OK  ]=0A=
modprobe: FATAL: Could not load /lib/modules/2.6.14/modules.dep: No such =
file or directory=0A=
=0A=
Cannot access the Hardware Clock via any known method.=0A=
Use the --debug option to see the details of our search for an access =
method.=0A=
Setting clock : Thu Jan  1 01:00:12 MET 1970 [  OK  ]=0A=
Setting hostname CHOISpad-110:  [  OK  ]=0A=
Mounting local filesystems:  [  OK  ]=0A=
Enabling swap space:  [  OK  ]=0A=
=0A=
INIT: Entering runlevel: 3=0A=
Entering non-interactive startup=0A=
Bringing up loopback interface:  modprobe: FATAL: Could not load =
/lib/modules/2.6.14/modules.dep: No such file or directory=0A=
=0A=
arping: socket: Address family not supported by protocol=0A=
Error, some other host already uses address 127.0.0.1.=0A=
[FAILED]=0A=
Starting system logger: [  OK  ]=0A=
Starting kernel logger: [  OK  ]=0A=
Starting portmap: [  OK  ]=0A=
Mounting NFS filesystems:  [  OK  ]=0A=
Mounting other filesystems:  [  OK  ]=0A=
Starting xinetd: [  OK  ]=0A=
=0A=
DENX ELDK version 4.0 build 2006-01-11=0A=
Linux 2.6.14 on a ppc=0A=
=0A=
CHOISpad-110 login: root=0A=
Last login: Thu Jan  1 01:00:19 on console=0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# hdparm -t=08 =08=08 =08/dev/hda=0A=
=0A=
/dev/hda:=0A=
 multcount    =3D  0 (off)=0A=
 I/O support  =3D  0 (default 16-bit)=0A=
 unmaskirq    =3D  1 (on)=0A=
 using_dma    =3D  1 (on)=0A=
 keepsettings =3D  0 (off)=0A=
 nowerr       =3D  0 (off)=0A=
 readonly     =3D  0 (off)=0A=
 readahead    =3D 256 (on)=0A=
 geometry     =3D 65535/16/63, sectors =3D 78165360, start =3D 0=0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# =0A=
bash-3.00# hdparm -t /dev/hda=0A=
=0A=
/dev/hda:=0A=
 Timing buffered__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
 disk reads:  got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
ide_execute_command : 0x10=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
got ocp_ide_dma_off_quietly=0A=
=0A=
ide0: reset: master: error (0x00?)=0A=
=0A=
ide_execute_command : 0x91=0A=
=0A=
ide_execute_command : 0x10=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
ide_execute_command : 0x10=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
__ide_do_rw_disk : dma 1 lba48 0 LBA=3D0=0A=
=0A=
got ocp_ide_dma_setup =0A=
=0A=
ide_execute_command : 0xc8=0A=
=0A=
got ocp_ide_dma_begin 0x1000=0A=
=0A=
DMA addr c1238000 1238000 count 8 dmastat 0=0A=
=0A=
DMA complete stat 20001000 0=0A=
=0A=
hda: lost interrupt=0A=
=0A=
got ocp_ide_dma_end 0 20000000=0A=
=0A=
ide_dma_intr : stat 58=0A=
=0A=
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }=0A=
=0A=
ide: failed opcode was: unknown=0A=
=0A=
got ocp_ide_dma_off_quietly=0A=
=0A=
ide0: reset: master: error (0x00?)=0A=
=0A=
end_request: I/O error, dev hda, sector 0=0A=
=0A=
Buffer I/O error on device hda, logical block 0=0A=
=0A=
end_request: I/O error, dev hda, sector 8=0A=
=0A=
Buffer I/O error on device hda, logical block 1=0A=
=0A=
end_request: I/O error, dev hda, sector 16=0A=
=0A=
Buffer I/O error on device hda, logical block 2=0A=
=0A=
end_request: I/O error, dev hda, sector 24=0A=
=0A=
Buffer I/O error on device hda, logical block 3=0A=
=0A=
end_request: I/O error, dev hda, sector 32=0A=
=0A=
Buffer I/O error on device hda, logical block 4=0A=
=0A=
end_request: I/O error, dev hda, sector 40=0A=
=0A=
Buffer I/O error on device hda, logical block 5=0A=
=0A=
end_request: I/O error, dev hda, sector 48=0A=
=0A=
Buffer I/O error on device hda, logical block 6=0A=
=0A=
end_request: I/O error, dev hda, sector 56=0A=
=0A=
Buffer I/O error on device hda, logical block 7=0A=
=0A=
end_request: I/O error, dev hda, sector 64=0A=
=0A=
Buffer I/O error on device hda, logical block 8=0A=
=0A=
end_request: I/O error, dev hda, sector 72=0A=
=0A=
Buffer I/O error on device hda, logical block 9=0A=
=0A=
end_request: I/O error, dev hda, sector 80=0A=
=0A=
end_request: I/O error, dev hda, sector 88=0A=
=0A=
end_request: I/O error, dev hda, sector 96=0A=
=0A=
end_request: I/O error, dev hda, sector 104=0A=
=0A=
end_request: I/O error, dev hda, sector 112=0A=
=0A=
end_request: I/O error, dev hda, sector 120=0A=
=0A=
end_request: I/O error, dev hda, sector 128=0A=
=0A=
end_request: I/O error, dev hda, sector 136=0A=
=0A=
end_request: I/O error, dev hda, sector 144=0A=
=0A=
end_request: I/O error, dev hda, sector 152=0A=
=0A=
end_request: I/O error, dev hda, sector 160=0A=
=0A=
end_request: I/O error, dev hda, sector 168=0A=
=0A=
end_request: I/O error, dev hda, sector 176=0A=
=0A=
end_request: I/O error, dev hda, sector 184=0A=
=0A=
end_request: I/O error, dev hda, sector 192=0A=
=0A=
end_request: I/O error, dev hda, sector 200=0A=
=0A=
end_request: I/O error, dev hda, sector 208=0A=
=0A=
end_request: I/O error, dev hda, sector 216=0A=
=0A=
end_request: I/O error, dev hda, sector 224=0A=
=0A=
end_request: I/O error, dev hda, sector 232=0A=
=0A=
end_request: I/O error, dev hda, sector 240=0A=
=0A=
end_request: I/O error, dev hda, sector 248=0A=
=0A=
end_request: I/O error, dev hda, sector 256=0A=
=0A=
end_request: I/O error, dev hda, sector 264=0A=
=0A=
end_request: I/O error, dev hda, sector 272=0A=
=0A=
end_request: I/O error, dev hda, sector 280=0A=
=0A=
end_request: I/O error, dev hda, sector 288=0A=
=0A=
end_request: I/O error, dev hda, sector 296=0A=
=0A=
end_request: I/O error, dev hda, sector 304=0A=
=0A=
end_request: I/O error, dev hda, sector 312=0A=
=0A=
end_request: I/O error, dev hda, sector 320=0A=
=0A=
end_request: I/O error, dev hda, sector 328=0A=
=0A=
end_request: I/O error, dev hda, sector 336=0A=
=0A=
end_request: I/O error, dev hda, sector 344=0A=
=0A=
end_request: I/O error, dev hda, sector 352=0A=
=0A=
end_request: I/O error, dev hda, sector 360=0A=
=0A=
end_request: I/O error, dev hda, sector 368=0A=
=0A=
end_request: I/O error, dev hda, sector 376=0A=
=0A=
end_request: I/O error, dev hda, sector 384=0A=
=0A=
end_request: I/O error, dev hda, sector 392=0A=
=0A=
end_request: I/O error, dev hda, sector 400=0A=
=0A=
end_request: I/O error, dev hda, sector 408=0A=
=0A=
end_request: I/O error, dev hda, sector 416=0A=
=0A=
end_request: I/O error, dev hda, sector 424=0A=
=0A=
end_request: I/O error, dev hda, sector 432=0A=
=0A=
end_request: I/O error, dev hda, sector 440=0A=
=0A=
end_request: I/O error, dev hda, sector 448=0A=
=0A=
end_request: I/O error, dev hda, sector 456=0A=
=0A=
end_request: I/O error, dev hda, sector 464=0A=
=0A=
end_request: I/O error, dev hda, sector 472=0A=
=0A=
end_request: I/O error, dev hda, sector 480=0A=
=0A=
end_request: I/O error, dev hda, sector 488=0A=
=0A=
end_request: I/O error, dev hda, sector 496=0A=
=0A=
end_request: I/O error, dev hda, sector 504=0A=
=0A=
end_request: I/O error, dev hda, sector 0=0A=
=0A=
read() failed: Input/output error=0A=
bash-3.00# 
------=_NextPart_000_001F_01C6D753.6EC1CD50
Content-Type: application/octet-stream;
	name="ibm_ocp_ide.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ibm_ocp_ide.c"

/*
*    IDE Driver Based on ocp_stbxxxx.c
*/

#include <linux/types.h>
#include <linux/hdreg.h>
#include <linux/delay.h>
#include <linux/ide.h>
#include <asm/ocp.h>
#include <asm/io.h>
#include <asm/scatterlist.h>
#include <asm/ppc4xx_dma.h>

#include "ide_modes.h"

#define IDEVR			"1.0"


#define TRUE  1
#define FALSE 0

#define IN_BYTE(p)             (byte)inb_p(p)
#define OUT_BYTE(b,p)          outb((b),(p))

typedef unsigned int ide_ioreg_t;

static int pio_mode[2] =3D { -1, -1 };

ppc_dma_ch_t dma_ch;

/* use DMA channel 2 for IDE DMA operations */
#define IDE_DMACH	2	/* 2nd DMA channel */
#define IDE_DMA_INT	6	/* IDE dma channel 2 interrupt */


//#define WMODE	1		/* default to DMA line mode */
#define PIOMODE	0
static volatile unsigned long dmastat;

/* Function Prototypes */
static void ocp_ide_tune_drive(ide_drive_t *, byte);
static byte ocp_ide_dma_2_pio(byte);
static int ocp_ide_tune_chipset(ide_drive_t *, byte);
static int ocp_ide_dma_on(ide_drive_t *drive);
static void ocp_dma_exec_cmd (ide_drive_t * const drive, u8 command);

static void
ocp_ide_tune_drive(ide_drive_t * drive, byte pio)
{
	pio =3D ide_get_best_pio_mode(drive, pio, 5, NULL);
	printk("ocp_ide_tune_drive pio %d\n",pio);
}

static byte
ocp_ide_dma_2_pio(byte xfer_rate)
{
	switch (xfer_rate) {
	case XFER_UDMA_5:
	case XFER_UDMA_4:
	case XFER_UDMA_3:
	case XFER_UDMA_2:
	case XFER_UDMA_1:
	case XFER_UDMA_0:
	case XFER_MW_DMA_2:
	case XFER_PIO_4:
		return 4;
	case XFER_MW_DMA_1:
	case XFER_PIO_3:
		return 3;
	case XFER_SW_DMA_2:
	case XFER_PIO_2:
		return 2;
	case XFER_MW_DMA_0:
	case XFER_SW_DMA_1:
	case XFER_SW_DMA_0:
	case XFER_PIO_1:
	case XFER_PIO_0:
	case XFER_PIO_SLOW:
	default:
		return 0;
	}
}

static int
ocp_ide_tune_chipset(ide_drive_t * drive, byte speed)
{
	int err =3D 0;

	printk("ocp_ide_tune_chipset speed %d\n",speed);
	ocp_ide_tune_drive(drive, ocp_ide_dma_2_pio(speed));

	if (!drive->init_speed)
		drive->init_speed =3D speed;
	err =3D ide_config_drive_speed(drive, speed);
	drive->current_speed =3D speed;
	printk("ocp_ide_tune_chipset speed %d\n",speed);
	return err;
}

static int
redwood_config_drive_for_dma(ide_drive_t * drive)
{
	struct hd_driveid *id =3D drive->id;
	byte speed;

	/*
	 * Enable DMA on any drive that has multiword DMA
	 */
	if (id->field_valid & 2) {
		if (id->dma_mword & 0x0004) {
			speed =3D XFER_MW_DMA_2;
		} else if (id->dma_mword & 0x0002) {
			speed =3D XFER_MW_DMA_1;
		} else if (id->dma_mword & 1) {
			speed =3D XFER_MW_DMA_0;
		} else if (id->dma_1word & 0x0004) {
			speed =3D XFER_SW_DMA_2;
		} else {
			speed =3D XFER_PIO_0 +
			    ide_get_best_pio_mode(drive, 255, 5, NULL);
		}
	}
	printk("redwood_config_drive_for_dma %x\n",speed);
	ocp_ide_tune_drive(drive, ocp_ide_dma_2_pio(speed));
	return  ocp_ide_dma_on(drive);
}



int
ocp_ide_dma_intr(int irq, void *dev_id, struct pt_regs *regs)
{
	unsigned long flags;
	unsigned long tmp;
=09
	local_irq_save(flags);
	//dmastat =3D ppc4xx_get_dma_status();
	dmastat =3D mfdcr(DCRN_DMASR);
#ifdef  WMODE
	if (dmastat & 0x1000) {
		//This should not happen at least in Word Mode, I have noticed this. =
Is it some timing problem ?
		printk
		    ("ocp_ide_dma_intr dma req pending from external device\n");
	}
#endif

	//mtdcr(DCRN_DMASR, ((u32)DMA_CH2_ERR | (u32)DMA_CS2 | (u32)DMA_TS2));
	mtdcr(DCRN_DMASR,0x22211120);

	/* disable DMA */
	/*uicdcr =3D mfdcr (DCRN_UIC_PR (UIC0));
	uicdcr &=3D ~(0x80000000ul >> IDE_DMA_INT);
	mtdcr (DCRN_UIC_PR(UIC0), uicdcr);
	mtdcr (DCRN_UIC_TR(UIC0),
        mfdcr (DCRN_UIC_TR (UIC0)) | (0x80000000ul >> IDE_DMA_INT));
	*/
	//ppc4xx_disable_dma_interrupt(IDE_DMACH);
	tmp =3D mfdcr(DCRN_DMASR);
	mtdcr (DCRN_UIC_SR(UIC0),(0x80000000ul >> IDE_DMA_INT));
	printk("GOT DMA interrupt %x %x\n",dmastat,tmp);
	local_irq_restore(flags);
	return 0;
	//ppc4xx_clr_dma_status(IDE_DMACH);
}

void
ibm25xx_ide_spinup(int index)
{
	int i,j;
	ide_ioreg_t *io_ports;

	printk("ide_redwood: waiting for drive ready..");
	io_ports =3D ide_hwifs[index].io_ports;

	/* wait until drive is not busy (it may be spinning up) */
	for (i =3D 0; i < 30; i++) {
		unsigned char stat;
		stat =3D inb_p(io_ports[7]);
		/* wait for !busy & ready */
		if ((stat & 0x80) =3D=3D 0) {
			break;
		}
		for(j=3D0;j<10;j++)
			udelay(1000 * 100);	/* 1 second */
	}

	printk("..");

	/* select slave */
	outb_p(0xa0 | 0x10, io_ports[6]);

	for (i =3D 0; i < 30; i++) {
		unsigned char stat;
		stat =3D inb_p(io_ports[7]);
		/* wait for !busy & ready */
		if ((stat & 0x80) =3D=3D 0) {
			break;
		}

		for(j=3D0;j<10;j++)
			udelay(1000 * 100);	/* 1 second */
	}

	printk("..");

	outb_p(0xa0, io_ports[6]);
	printk("Drive spun up \n");
}

static int ocp_ide_dma_off(ide_drive_t *drive){

	printk("got ocp_ide_dma_off\n");
	return 0;;
}
static int ocp_ide_dma_off_quietly(ide_drive_t *drive){
	printk("got ocp_ide_dma_off_quietly\n");
	return 0;
}
static int ocp_ide_dma_on(ide_drive_t *drive){
	ide_hwif_t *hwif =3D HWIF(drive);
	int i, reading =3D 0;
	struct request *rq =3D HWGROUP(drive)->rq;
	unsigned long flags;
	unsigned long length;


		printk("got ocp_ide_dma_on\n");
#if PIOMODE
		return 1;
#endif

		mtdcr(DCRN_DMACR2, 0);
		ppc4xx_clr_dma_status(IDE_DMACH);

		/*save_flags(flags);
		cli();
		if (request_irq (IDE_DMA_INT, &ocp_ide_dma_intr, =
SA_INTERRUPT,"IDE-DMA", hwif->hwgroup)) {
			printk("ide_redwood6: ide_request_irq failed int=3D%d\n", =
IDE_DMA_INT);
			//restore_flags(flags);
			//return 1;
		}
		restore_flags(flags);
		*/

		drive->using_dma =3D 1;
#ifdef WMODE
		mtdcr(DCRN_DCRXBCR, 0);
		mtdcr(DCRN_CICCR, mfdcr(DCRN_CICCR) | 0x00000400);
#else
		/* Configure CIC reg for line mode dma */
		mtdcr(DCRN_CICCR, mfdcr(DCRN_CICCR) & ~0x00000400);
#endif
		return 0;
}
static int ocp_ide_dma_check(ide_drive_t *drive){

	printk("got ocp_ide_dma_check\n");
	return redwood_config_drive_for_dma(drive);
}

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
	=09
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
	control |=3D DMA_CIE_ENABLE;	 Channel Interrupt Enable=20
	*/
	control &=3D ~DMA_CIE_ENABLE;
	mtdcr(DCRN_DMACR2, control);
	//ppc4xx_enable_dma_interrupt(IDE_DMACH);
=09
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
static int ocp_ide_dma_test_irq(ide_drive_t *drive){

	printk("got ocp_ide_dma_test_irq\n");
	return 1;	/* returns 1 if dma irq issued, 0 otherwise */
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
	ide_hwif_t 	* const hwif =3D HWIF(drive);
	struct request * const rq =3D HWGROUP(drive)->rq;

	printk("got ocp_ide_dma_setup \n");
	/*if(rq->current_nr_sectors < 2){
		printk("request for less no of sectors %d\n",rq->current_nr_sectors);
		ide_map_sg(drive,rq);drive->waiting_for_dma=3D0;=20
		return 1;
	}*/
	drive->waiting_for_dma =3D 1;
	return 0;
}=09


static void
ocp_ide_setup_dma (ide_hwif_t * const hwif)
{
	printk("ocp_ide_setup_dma \n");


	hwif->dma =3D IDE_DMACH;
#ifdef WMODE
   /*Word Mode psc(11-12)=3D00,pwc(13-18)=3D000110, phc(19-21)=3D010, =
22=3D1, 30=3D1  ----  0xCB02*/

	dma_ch.mode	=3DTM_S_MM;	  /* xfer from peripheral to mem */
	dma_ch.td	=3D DMA_TD;
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
	dma_ch.ch_enable =3D FALSE;		/* No chaining */
	dma_ch.tcd_disable =3D TRUE;		/* No chaining */
#else
/*Line Mode psc(11-12)=3D00,pwc(13-18)=3D000001, phc(19-21)=3D010, =
22=3D1, 30=3D1  ----  0x2B02*/

	dma_ch.mode	=3DDMA_MODE_MM_DEVATSRC;	  /* xfer from peripheral to mem =
*/
	dma_ch.td	=3D DMA_TD;
	dma_ch.buffer_enable =3D FALSE;
	dma_ch.tce_enable =3D FALSE;
	dma_ch.etd_output =3D FALSE;
	dma_ch.pce =3D FALSE;
	dma_ch.pl =3D EXTERNAL_PERIPHERAL;    /* no op */
	dma_ch.pwidth =3D PW_64;		/* Line mode on stbs */
	dma_ch.dai =3D TRUE;
	dma_ch.sai =3D FALSE;
	dma_ch.psc =3D 0;                      /* set the max setup cycles */
	dma_ch.pwc =3D 1;                     /* set the max wait cycles  */
	dma_ch.phc =3D 2;                      /* set the max hold cycles  */
	dma_ch.cp =3D PRIORITY_LOW;
	dma_ch.int_enable =3D FALSE;
	dma_ch.ch_enable =3D FALSE;		/* No chaining */
	dma_ch.tcd_disable =3D TRUE;		/* No chaining */

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
	hwif->ide_dma_host_off		 =3D &ocp_ide_dma_off_quietly;
	hwif->ide_dma_host_on  		 =3D &ocp_ide_dma_on;

	hwif->ide_dma_check		 =3D &ocp_ide_dma_check;
	hwif->ide_dma_off_quietly 	 =3D &ocp_ide_dma_off_quietly;
	hwif->ide_dma_on          	 =3D &ocp_ide_dma_on;

	hwif->dma_setup   		 =3D &ocp_ide_dma_setup;
	hwif->dma_exec_cmd 		 =3D &ocp_dma_exec_cmd;
	hwif->dma_start    		 =3D &ocp_ide_dma_begin;
	hwif->ide_dma_end 		 =3D &ocp_ide_dma_end;

	hwif->ide_dma_test_irq		 =3D &ocp_ide_dma_test_irq;

	hwif->ide_dma_lostirq 		 =3D &ocp_ide_dma_lostirq;
	hwif->ide_dma_timeout 		 =3D &ocp_ide_dma_timeout;
}
	=09
static int __init
stb025xx_ide_probe (struct ocp_device * const ocp)
{
	int                     err;
	unsigned int            uicdcr;
	volatile unsigned long	ide_regs;
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
=09
	/* initialize */
	hwif->gendev.parent =3D &ocp->dev;
	ocp_set_drvdata (ocp, hwif);

	/* setup MMIO ops */
	default_hwif_mmiops (hwif);

	/* tell common code _not_ to mess with resources */
	hwif->mmio =3D 2;
	ide_set_hwifdata (hwif, (void *) ide_regs);
=09
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
=09
	ibm25xx_ide_spinup(0);
	ocp_ide_setup_dma (hwif);
	probe_hwif_init (hwif);

	create_proc_ide_interfaces ();
	printk("IDE probe finished \n");
	return 0;
}

static void
stb025xx_ide_remove (struct ocp_device * const ocp)
{
	ide_hwif_t             * const hwif =3D ocp_get_drvdata (ocp);

	hwif->dmatable_cpu =3D NULL;
	hwif->dmatable_dma =3D 0;

	ide_unregister (hwif->index);
	ocp_force_power_off (ocp);
}


static struct ocp_device_id stb025xx_ide_ids[] __devinitdata =3D
{
        { .vendor =3D OCP_VENDOR_IBM, .function =3D OCP_FUNC_IDE},
        { .vendor =3D OCP_VENDOR_INVALID }
};

MODULE_DEVICE_TABLE (ocp, stb04xxx_ide_ids);

static struct ocp_driver stb025xx_ide_driver =3D {
	.name     =3D "ide",
	.id_table =3D stb025xx_ide_ids,
	.probe    =3D stb025xx_ide_probe,
	.remove   =3D __devexit_p (stb025xx_ide_remove),
#if defined(CONFIG_PM)
	.suspend  =3D NULL,
	.resume   =3D NULL,
#endif
};



int __init
stb025xx_ide_init (void)
{
	printk("inside stb04xxx_ide_init \n");
	return ocp_register_driver (&stb025xx_ide_driver);
}

static void __exit
stb025xx_ide_exit (void)
{
	printk("inside stb04xxx_ide_exit \n");
	ocp_unregister_driver (&stb025xx_ide_driver);
}

/* needs to be called after ide has been initialized */
late_initcall (stb025xx_ide_init);
module_exit (stb025xx_ide_exit);

MODULE_LICENSE ("GPL");
MODULE_AUTHOR ("Akhilesh Soni <akhilesh@innomedia.soft.net>");
MODULE_DESCRIPTION ("driver for IBM OCP IDE on STB025xx");

------=_NextPart_000_001F_01C6D753.6EC1CD50--
