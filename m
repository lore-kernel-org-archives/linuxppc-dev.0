Return-Path: <jxnuxdy@163.com>
Received: from m13-14.163.com (m13-14.163.com [220.181.13.14])
	by ozlabs.org (Postfix) with SMTP id 173E667A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 12:27:43 +1000 (EST)
MIME-Version: 1.0
Message-ID: <4488D8D1.00003F.15159@bj163app14.163.com>
Date: Fri, 9 Jun 2006 10:11:29 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: "wolfgang denk" <wd@denx.de>
Subject: Help -- failed to boot up kernel on PPC40
 5
References: <20060608214239.A71EE35265D@atlas.denx.de>
In-Reply-To: <20060608214239.A71EE35265D@atlas.denx.de>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_NUsmVwxwJHlEhGDIsOSMdbfHPcBT"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_NUsmVwxwJHlEhGDIsOSMdbfHPcBT
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Dear Denk,
 
      I use the linux 2.6.14 of your website, and compile it with the ELDK4.0 succesfully, but when I download it to my PPC405 board, it stopped after initialized the MMU, and encounter an exception in "_start_here".
 
Logs:
u-boot => tftpboot 0x6000000 uImage
miiphy_register: non unique device name 'ppc_4xx_eth0'
ENET Speed is 100 Mbps - FULL duplex connection
TFTP from server 192.168.65.235; our IP address is 192.168.65.239
Filename 'uImage'.
Load address: 0x6000000
Loading: #################################################################
         #####################################
done
Bytes transferred = 521637 (7f5a5 hex)
u-boot => bootm 0x6000000
## Booting image at 0x06000000 ...
   Image Name:   Linux-2.6.14
   Created:      2006-06-09   1:00:37 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    521573 Bytes = 509.3 kB
   Load Address: 0x00100000
   Entry Point:  0x00100000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Now starting to boot the kernel...
## Current stack ends at 0x07F81A90 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF00
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFFFA0000
flashsize   = 0x01080000
flashoffset = 0x00029300
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x0000A000
procfreq    =    200 MHz
plb_busfreq =    100 MHz
pci_busfreq = 33.333 MHz
ethaddr     = 00:01:02:54:12:47
IP addr     = 192.168.65.239
baudrate    =   9600 bps
Ramdisk image not found, no initrd!
## Transferring control to Linux (at address 0x00100000) ...
booting kernel with FLAT_TREE...
NIP: C000221C XER: 20000000 LR: 00100018 REGS: 07f819a0 TRAP: 0700 DAR: 07FC31D0
MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
GPR00: C0002218 07F81A90 00000000 C00003C0 C0000000 00000000 007FFF00 007FFF00 
GPR08: 07FAB560 0BEBC200 00000000 00000000 20BDE736 00000000 07FD0D00 007FFF00 
GPR16: 00100000 07FCF70C FFFFFFFF 00000000 00800000 007FFF00 07FCAE20 00000002 
GPR24: 07F81B50 007FFE70 00780000 007FFF00 007FFF00 00000000 00000000 007FFE70 
** Illegal Instruction **
Call backtrace: 
Program Check Exception

U-Boot 1.1.4 (Jun  9 2006 - 09:36:28)
...
...
My objdump file is as the following:
...
c0002208: 7c 00 04 ac  sync    
c000220c: 4c 00 00 64  rfi
c0002210: 48 00 00 00  b       c0002210 <finish_tlb_load+0x48>
c0002214 <giveup_fpu>:
c0002214: 4e 80 00 20  blr
c0002218 <start_here>:
c0002218: 3c 40 c0 0f  lis     r2,-16369
c000221c: 60 42 17 60  ori     r2,r2,5984
c0002220: 3c 82 40 00  addis   r4,r2,16384
c0002224: 38 84 01 c8  addi    r4,r4,456
...
 
Best Regards!
- Denny
 
--Boundary-=_NUsmVwxwJHlEhGDIsOSMdbfHPcBT
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Dear Denk,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I use the linux 2.6.14 of your websit=
e, and compile it with the ELDK4.0 succesfully, but when I download it to=
 my PPC405 board, it stopped after initialized the MMU, and encounter an =
exception in "_start_here".</DIV>
<DIV>&nbsp;</DIV>
<DIV>Logs:</DIV>
<DIV>u-boot =3D&gt; tftpboot 0x6000000 uImage<BR>miiphy_register: non uni=
que device name 'ppc_4xx_eth0'<BR>ENET Speed is 100 Mbps - FULL duplex co=
nnection<BR>TFTP from server 192.168.65.235; our IP address is 192.168.65=
=2E239<BR>Filename 'uImage'.<BR>Load address: 0x6000000<BR>Loading: #####=
############################################################<BR>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################=
####<BR>done<BR>Bytes transferred =3D 521637 (7f5a5 hex)<BR>u-boot =3D&gt=
; bootm 0x6000000<BR>## Booting image at 0x06000000 ...<BR>&nbsp;&nbsp; I=
mage Name:&nbsp;&nbsp; Linux-2.6.14<BR>&nbsp;&nbsp; Created:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 2006-06-09&nbsp;&nbsp; 1:00:37 UTC<BR>&nbsp;&nbsp; Imag=
e Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp=
;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 521573 Bytes =3D 509.3 kB<BR>&nbsp;&=
nbsp; Load Address: 0x00100000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 0x00100=
000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressi=
ng Kernel Image ... OK<BR>Now starting to boot the kernel...<BR>## Curren=
t stack ends at 0x07F81A90 =3D&gt; set upper limit to 0x00800000<BR>## cm=
dline at 0x007FFF00 ... 0x007FFF00<BR>memstart&nbsp;&nbsp;&nbsp; =3D 0x00=
000000<BR>memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x08000000<BR>flashstart&nb=
sp; =3D 0xFFFA0000<BR>flashsize&nbsp;&nbsp; =3D 0x01080000<BR>flashoffset=
 =3D 0x00029300<BR>sramstart&nbsp;&nbsp; =3D 0x00000000<BR>sramsize&nbsp;=
&nbsp;&nbsp; =3D 0x00000000<BR>bootflags&nbsp;&nbsp; =3D 0x0000A000<BR>pr=
ocfreq&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 200 MHz<BR>plb_busfreq =3D=
&nbsp;&nbsp;&nbsp; 100 MHz<BR>pci_busfreq =3D 33.333 MHz<BR>ethaddr&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 00:01:02:54:12:47<BR>IP addr&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 192.168.65.239<BR>baudrate&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 9600 =
bps<BR>Ramdisk image not found, no initrd!<BR>## Transferring control to =
Linux (at address 0x00100000) ...<BR>booting kernel with FLAT_TREE...<BR>=
NIP: C000221C XER: 20000000 LR: 00100018 REGS: 07f819a0 TRAP: 0700 DAR: 0=
7FC31D0<BR>MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11</DIV>
<DIV>GPR00: C0002218 07F81A90 00000000 C00003C0 C0000000 00000000 007FFF0=
0 007FFF00 <BR>GPR08: 07FAB560 0BEBC200 00000000 00000000 20BDE736 000000=
00 07FD0D00 007FFF00 <BR>GPR16: 00100000 07FCF70C FFFFFFFF 00000000 00800=
000 007FFF00 07FCAE20 00000002 <BR>GPR24: 07F81B50 007FFE70 00780000 007F=
FF00 007FFF00 00000000 00000000 007FFE70 <BR>** Illegal Instruction **<BR=
>Call backtrace: <BR>Program Check Exception</DIV>
<DIV><BR>U-Boot 1.1.4 (Jun&nbsp; 9 2006 - 09:36:28)</DIV>
<DIV>...</DIV>
<DIV>...</DIV>
<DIV>My objdump file is as the following:</DIV>
<DIV>...</DIV>
<DIV>c0002208:&nbsp;7c 00 04 ac &nbsp;sync&nbsp;&nbsp;&nbsp; <BR>c000220c=
:&nbsp;4c 00 00 64 &nbsp;rfi<BR>c0002210:&nbsp;48 00 00 00 &nbsp;b&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0002210 &lt;finish_tlb_load+0x48&gt;</DIV>
<DIV>c0002214 &lt;giveup_fpu&gt;:<BR>c0002214:&nbsp;4e 80 00 20 &nbsp;blr=
</DIV>
<DIV>c0002218 &lt;start_here&gt;:<BR>c0002218:&nbsp;3c 40 c0 0f &nbsp;lis=
&nbsp;&nbsp;&nbsp;&nbsp; r2,-16369<BR>c000221c:&nbsp;60 42 17 60 &nbsp;or=
i&nbsp;&nbsp;&nbsp;&nbsp; r2,r2,5984<BR>c0002220:&nbsp;3c 82 40 00 &nbsp;=
addis&nbsp;&nbsp; r4,r2,16384<BR>c0002224:&nbsp;38 84 01 c8 &nbsp;addi&nb=
sp;&nbsp;&nbsp; r4,r4,456</DIV>
<DIV>...</DIV>
<DIV>&nbsp;</DIV>
<DIV>Best Regards!</DIV>
<DIV>- Denny</DIV>
<DIV>&nbsp;</DIV><SPAN ></SPAN><br><!-- footer --><br><br><br><br><br><di=
v style=3D"border-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=C4=E3 =B2=BB =CF=EB =
=CA=D4 =CA=D4 =BD=F1 =CF=C4 =D7=EE =A1=B0=BF=E1=A1=B1 =B5=C4 =D3=CA =CF=E4=
 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=D4=CC =BA=AD =D6=D0 =BB=AA =B4=AB =CD=B3=
 =CE=C4 =BB=AF =D3=DA =CA=C0 =BD=E7 =D2=BB =C1=F7 =BF=C6 =BC=BC =D6=AE =D6=
=D0=A3=AC=B4=B4 =D0=C2 Ajax =BC=BC =CA=F5=A3=AC126 =A1=B0D =BC=C6 =BB=AE=A1=
=B1=BB=F0 =C8=C8 =CC=E5 =D1=E9 =D6=D0 =A3=A1
</a>


--Boundary-=_NUsmVwxwJHlEhGDIsOSMdbfHPcBT--
