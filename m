Return-Path: <gturnock@ivhs.com>
Received: from postfix.fpelectronics.com (gw.ivhs.com [66.46.242.98])
	by ozlabs.org (Postfix) with ESMTP id 7E430679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Jul 2006 08:43:47 +1000 (EST)
Received: from notes.fpelectronics.com (notes.fpelectronics.com [172.17.10.15])
	by postfix.fpelectronics.com (Postfix) with ESMTP id 13F821D6285
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 17:49:50 -0400 (EDT)
Subject: MPC5200 boot giving "request_module: runaway loop modprobe
	binfmt-4c46" errors
MIME-Version: 1.0
From: gturnock@ivhs.com
To: linuxppc-embedded@ozlabs.org
Date: Fri, 7 Jul 2006 18:15:53 -0400
Message-ID: <OF8ECEFEB4.081DB077-ON852571A4.007A4DD5-852571A4.007A4DEE@fpelectronics.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><P>Hi All,</P><P>I am currently attempting to get the 2.6 Linux Kernel=
 ( Sylvain's&nbsp;Kernel from <A href=3D"http://gitbits.246tNt.com/gitbits/=
linux-2.6-mpc52xx.git" target=3Dblank>http://gitbits.246tNt.com/gitbits/lin=
ux-2.6-mpc52xx.git</A>) &nbsp;booting over NFS on a Freescale LITE5200 boar=
d.&nbsp; At present, I have been able to successfully mount the rootfs over=
 NFS, but am encountering the following issue... </P><P>After the kernel fr=
ees the unused memory after the NFS mount, I get a string of </P><P><FONT f=
ace=3D"Courier New">request=5Fmodule: runaway loop modprobe binfmt-4c46</FO=
NT></P><P><FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-ser=
if">errors and the console appears to hang.&nbsp; Any help would be greatly=
 appreciated!</FONT></P><P>A copy of the bootlog follows.</P><P>&nbsp;</P><=
P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">U-Boot 1.1=
.4 (May 1 2006 - 10:27:04)</FONT></P><P><FONT face=3D"Default Monospace,Cou=
rier New,Courier,monospace">CPU: MPC5200 v1.2 at 396 MHz</FONT></P><P><FONT=
 face=3D"Default Monospace,Courier New,Courier,monospace">Bus 132 MHz, IPB =
66 MHz, PCI 33 MHz</FONT></P><P><FONT face=3D"Default Monospace,Courier New=
,Courier,monospace">Board: Motorola MPC5200 (IceCube)</FONT></P><P><FONT fa=
ce=3D"Default Monospace,Courier New,Courier,monospace">I2C: 85 kHz, ready</=
FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">=
DRAM: 64 MB</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courie=
r,monospace">FLASH: 16 MB</FONT></P><P><FONT face=3D"Default Monospace,Cour=
ier New,Courier,monospace">PCI: Bus Dev VenId DevId Class Int</FONT></P><P>=
<FONT face=3D"Default Monospace,Courier New,Courier,monospace">00 1a 1057 5=
803 0680 00</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courie=
r,monospace">In: serial</FONT></P><P><FONT face=3D"Default Monospace,Courie=
r New,Courier,monospace">Out: serial</FONT></P><P><FONT face=3D"Default Mon=
ospace,Courier New,Courier,monospace">Err: serial</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">Net: FEC ETHERNET</FON=
T></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">IDE=
: Bus 0: not available </FONT></P><P><FONT face=3D"Default Monospace,Courie=
r New,Courier,monospace">Autostarting... Press any key to abort...</FONT></=
P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">Hit any=
 key to stop autoboot: 5 4 3 2 1 0</FONT></P><P><FONT face=3D"Default Monos=
pace,Courier New,Courier,monospace">Using FEC ETHERNET device</FONT></P><P>=
<FONT face=3D"Default Monospace,Courier New,Courier,monospace">TFTP from se=
rver 192.168.0.39; our IP address is 192.168.0.50</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">Filename '/tftpboot/MP=
C5200=5F2=5F6/uImage'.</FONT></P><P><FONT face=3D"Default Monospace,Courier=
 New,Courier,monospace">Load address: 0x200000</FONT></P><P><FONT face=3D"D=
efault Monospace,Courier New,Courier,monospace">Loading: *=08##############=
###################################################</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">######################=
###########################################</FONT></P><P><FONT face=3D"Defa=
ult Monospace,Courier New,Courier,monospace">##############################=
###################################</FONT></P><P><FONT face=3D"Default Mono=
space,Courier New,Courier,monospace">######################################=
########################</FONT></P><P><FONT face=3D"Default Monospace,Couri=
er New,Courier,monospace">done</FONT></P><P><FONT face=3D"Default Monospace=
,Courier New,Courier,monospace">Bytes transferred =3D 1314615 (140f37 hex)<=
/FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace"=
>ethaddr=3D00:04:9F:00:01:02</FONT></P><P><FONT face=3D"Default Monospace,C=
ourier New,Courier,monospace">hostname=3Dmpc5200</FONT></P><P><FONT face=3D=
"Default Monospace,Courier New,Courier,monospace">flash=5Fjffs2=3Drun jffs2=
args;bootm ${kernel=5Faddr}</FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">bootdelay=3D5</FONT></P><P><FONT face=3D"Defau=
lt Monospace,Courier New,Courier,monospace">baudrate=3D115200</FONT></P><P>=
<FONT face=3D"Default Monospace,Courier New,Courier,monospace">preboot=3Dec=
ho;echo Autostarting... Press any key to abort...;echo</FONT></P><P><FONT f=
ace=3D"Default Monospace,Courier New,Courier,monospace">autoload=3Dno</FONT=
></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">etha=
ct=3DFEC ETHERNET</FONT></P><P><FONT face=3D"Default Monospace,Courier New,=
Courier,monospace">ramargs=3Dsetenv bootargs root=3D/dev/ram rw</FONT></P><=
P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">jffs2args=
=3Dsetenv bootargs root=3D/dev/mtdblock0 rw rootfstype=3Djffs2</FONT></P><P=
><FONT face=3D"Default Monospace,Courier New,Courier,monospace">flash=5Fnfs=
=3Drun nfsargs addip;bootm $(kernel=5Faddr)</FONT></P><P><FONT face=3D"Defa=
ult Monospace,Courier New,Courier,monospace">flash=5Fself=3Drun ramargs add=
ip;bootm $(kernel=5Faddr) $(ramdisk=5Faddr)</FONT></P><P><FONT face=3D"Defa=
ult Monospace,Courier New,Courier,monospace">netdev=3Deth0</FONT></P><P><FO=
NT face=3D"Default Monospace,Courier New,Courier,monospace">kernel=5Faddr=
=3Dffd00000</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courie=
r,monospace">bootcmd=3Drun net=5Fnfs</FONT></P><P><FONT face=3D"Default Mon=
ospace,Courier New,Courier,monospace">net=5Fnfs=3Dtftp 200000 $(bootfile);r=
un nfsargs addip;printenv;bootm</FONT></P><P><FONT face=3D"Default Monospac=
e,Courier New,Courier,monospace">addip=3Dsetenv bootargs $(bootargs) ip=3D$=
(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off pani=
c=3D5</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,mono=
space">flash=5Fjff2=3Drun jffs2args; bootm $(kernel=5Faddr)</FONT></P><P><F=
ONT face=3D"Default Monospace,Courier New,Courier,monospace">bootfile=3D/tf=
tpboot/MPC5200=5F2=5F6/uImage</FONT></P><P><FONT face=3D"Default Monospace,=
Courier New,Courier,monospace">root=5Fpath=3D/tftpboot/MPC5200=5F2=5F6/root=
fs</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospa=
ce">nfsargs=3Dsetenv bootargs console=3DttyPSC0,115200 root=3D/dev/nfs rw n=
fsroot=3D$(serverip):$(root=5Fpath)</FONT></P><P><FONT face=3D"Default Mono=
space,Courier New,Courier,monospace">stdin=3Dserial</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">stdout=3Dserial</FONT>=
</P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">stder=
r=3Dserial</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier=
,monospace">filesize=3D140f37</FONT></P><P><FONT face=3D"Default Monospace,=
Courier New,Courier,monospace">fileaddr=3D200000</FONT></P><P><FONT face=3D=
"Default Monospace,Courier New,Courier,monospace">netmask=3D255.255.255.0</=
FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">=
ipaddr=3D192.168.0.50</FONT></P><P><FONT face=3D"Default Monospace,Courier =
New,Courier,monospace">serverip=3D192.168.0.39</FONT></P><P><FONT face=3D"D=
efault Monospace,Courier New,Courier,monospace">bootargs=3Dconsole=3DttyPSC=
0,115200 root=3D/dev/nfs rw nfsroot=3D192.168.0.39:/tftpboot/MPC5200=5F2=5F=
6/rootfs ip=3D192.168.0.50:192.168.0.39::255.255.255.0:mpc5200:eth0:off pan=
ic=3D5</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,mon=
ospace">Environment size: 1198/65532 bytes</FONT></P><P><FONT face=3D"Defau=
lt Monospace,Courier New,Courier,monospace">## Booting image at 00200000 ..=
.</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospac=
e">Image Name: Linux-2.6.16-mpc52xx-ga8651bf3-d</FONT></P><P><FONT face=3D"=
Default Monospace,Courier New,Courier,monospace">Created: 2006-07-07 20:56:=
15 UTC</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,mon=
ospace">Image Type: PowerPC Linux Kernel Image (gzip compressed)</FONT></P>=
<P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">Data Size=
: 1314551 Bytes =3D 1.3 MB</FONT></P><P><FONT face=3D"Default Monospace,Cou=
rier New,Courier,monospace">Load Address: 00000000</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">Entry Point: 00000000<=
/FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace"=
>Verifying Checksum ... OK</FONT></P><P><FONT face=3D"Default Monospace,Cou=
rier New,Courier,monospace">Uncompressing Kernel Image ... OK</FONT></P><P>=
<FONT face=3D"Default Monospace,Courier New,Courier,monospace">id mach(): d=
one</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monosp=
ace">MMU:enter</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Cou=
rier,monospace">MMU:hw init</FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">MMU:mapin</FONT></P><P><FONT face=3D"Default M=
onospace,Courier New,Courier,monospace">MMU:setio</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">MMU:exit</FONT></P><P>=
<FONT face=3D"Default Monospace,Courier New,Courier,monospace">setup=5Farch=
: enter</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,mo=
nospace">setup=5Farch: bootmem</FONT></P><P><FONT face=3D"Default Monospace=
,Courier New,Courier,monospace">arch: exit</FONT></P><P><FONT face=3D"Defau=
lt Monospace,Courier New,Courier,monospace">Linux version 2.6.16-mpc52xx-ga=
8651bf3-dirty (gturnock@localhost.localdomain) (gcc version 4.0.0 (DENX ELD=
K 4.0 4.0.0)) #4 Fri Jul 7 16:56:01 EDT 2006</FONT></P><P><FONT face=3D"Def=
ault Monospace,Courier New,Courier,monospace">Built 1 zonelists</FONT></P><=
P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">Kernel com=
mand line: console=3DttyPSC0,115200 root=3D/dev/nfs rw nfsroot=3D192.168.0.=
39:/tftpboot/MPC5200=5F2=5F6/rootfs ip=3D192.168.0.50:192.168.0.39::255.255=
.255.0:mpc5200:eth0:off panic=3D5</FONT></P><P><FONT face=3D"Default Monosp=
ace,Courier New,Courier,monospace">PID hash table entries: 512 (order: 9, 8=
192 bytes)</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier=
,monospace">Console: colour dummy device 80x25</FONT></P><P><FONT face=3D"D=
efault Monospace,Courier New,Courier,monospace">Dentry cache hash table ent=
ries: 16384 (order: 4, 65536 bytes)</FONT></P><P><FONT face=3D"Default Mono=
space,Courier New,Courier,monospace">Inode-cache hash table entries: 8192 (=
order: 3, 32768 bytes)</FONT></P><P><FONT face=3D"Default Monospace,Courier=
 New,Courier,monospace">Memory: 62080k available (2052k kernel code, 608k d=
ata, 104k init, 0k highmem)</FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">Mount-cache hash table entries: 512</FONT></P>=
<P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">NET: Regi=
stered protocol family 16</FONT></P><P><FONT face=3D"Default Monospace,Cour=
ier New,Courier,monospace"></FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">PCI: Probing PCI hardware</FONT></P><P><FONT f=
ace=3D"Default Monospace,Courier New,Courier,monospace">DMA: MPC52xx BestCo=
mm driver</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,=
monospace">MPC52xx BestComm inited</FONT></P><P><FONT face=3D"Default Monos=
pace,Courier New,Courier,monospace">Generic PHY: Registered new driver</FON=
T></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">JFS=
: nTxBlock =3D 485, nTxLock =3D 3883</FONT></P><P><FONT face=3D"Default Mon=
ospace,Courier New,Courier,monospace">Initializing Cryptographic API</FONT>=
</P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">io sc=
heduler noop registered</FONT></P><P><FONT face=3D"Default Monospace,Courie=
r New,Courier,monospace">io scheduler anticipatory registered (default)</FO=
NT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">io=
 scheduler deadline registered</FONT></P><P><FONT face=3D"Default Monospace=
,Courier New,Courier,monospace">io scheduler cfq registered</FONT></P><P><F=
ONT face=3D"Default Monospace,Courier New,Courier,monospace">Serial: MPC52x=
x PSC driver</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Couri=
er,monospace">ttyPSC0 at MMIO 0xf0002000 (irq =3D 40) is a MPC52xx PSC</FON=
T></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">RAM=
DISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize</FONT></=
P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">nbd: re=
gistered device at major 43</FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">LXT970: Registered new driver</FONT></P><P><FO=
NT face=3D"Default Monospace,Courier New,Courier,monospace">LXT971: Registe=
red new driver</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Cou=
rier,monospace">eth0: Phy @ 0x0, type LXT971 (0x001378e2)</FONT></P><P><FON=
T face=3D"Default Monospace,Courier New,Courier,monospace">mice: PS/2 mouse=
 device common for all mice</FONT></P><P><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace">NET: Registered protocol family 2</FONT></P><P=
><FONT face=3D"Default Monospace,Courier New,Courier,monospace">IP route ca=
che hash table entries: 1024 (order: 0, 4096 bytes)</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">TCP established hash t=
able entries: 4096 (order: 2, 16384 bytes)</FONT></P><P><FONT face=3D"Defau=
lt Monospace,Courier New,Courier,monospace">TCP bind hash table entries: 40=
96 (order: 2, 16384 bytes)</FONT></P><P><FONT face=3D"Default Monospace,Cou=
rier New,Courier,monospace">TCP: Hash tables configured (established 4096 b=
ind 4096)</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,=
monospace">TCP reno registered</FONT></P><P><FONT face=3D"Default Monospace=
,Courier New,Courier,monospace">TCP bic registered</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">NET: Registered protoc=
ol family 10</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Couri=
er,monospace">IPv6 over IPv4 tunneling driver</FONT></P><P><FONT face=3D"De=
fault Monospace,Courier New,Courier,monospace">eth0: config: auto-negotiati=
on on, 100HDX, 10HDX.</FONT></P><P><FONT face=3D"Default Monospace,Courier =
New,Courier,monospace">IP-Config: Complete:</FONT></P><P><FONT face=3D"Defa=
ult Monospace,Courier New,Courier,monospace">device=3Deth0, addr=3D192.168.=
0.50, mask=3D255.255.255.0, gw=3D255.255.255.255,</FONT></P><P><FONT face=
=3D"Default Monospace,Courier New,Courier,monospace">host=3Dmpc5200, domain=
=3D, nis-domain=3D(none),</FONT></P><P><FONT face=3D"Default Monospace,Cour=
ier New,Courier,monospace">bootserver=3D192.168.0.39, rootserver=3D192.168.=
0.39, rootpath=3D</FONT></P><P><FONT face=3D"Default Monospace,Courier New,=
Courier,monospace">Looking up port of RPC 100003/2 on 192.168.0.39</FONT></=
P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace">Looking=
 up port of RPC 100005/1 on 192.168.0.39</FONT></P><P><FONT face=3D"Default=
 Monospace,Courier New,Courier,monospace">VFS: Mounted root (nfs filesystem=
).</FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospa=
ce">Freeing unused kernel memory: 104k init</FONT></P><P><FONT face=3D"Defa=
ult Monospace,Courier New,Courier,monospace">request=5Fmodule: runaway loop=
 modprobe binfmt-4c46</FONT></P><P><FONT face=3D"Default Monospace,Courier =
New,Courier,monospace">request=5Fmodule: runaway loop modprobe binfmt-4c46<=
/FONT></P><P><FONT face=3D"Default Monospace,Courier New,Courier,monospace"=
>request=5Fmodule: runaway loop modprobe binfmt-4c46</FONT></P><P><FONT fac=
e=3D"Default Monospace,Courier New,Courier,monospace">request=5Fmodule: run=
away loop modprobe binfmt-4c46</FONT></P><P><FONT face=3D"Default Monospace=
,Courier New,Courier,monospace">request=5Fmodule: runaway loop modprobe bin=
fmt-4c46</FONT></P><P>&nbsp;</P><P>Any assistance would be greatly apprecia=
ted</P><P>Glenn</P><DIV><BR></DIV><DIV>------------------------------------=
----------<BR>Glenn Turnock<BR>Software Engineer<BR>MarkIV Industries - IVH=
S Division<BR>6020 Ambler Drive<BR>Mississauga, Ontario<BR>Canada <BR>L4W 2=
P1<BR><BR>Tel: 905-624-3025 x1295<BR>Fax: 905-624-4572<BR><BR><A href=3D"ma=
ilto:gturnock@ivhs.com" target=3Dblank >gturnock@ivhs.com</A><BR></DIV></FO=
NT>=
