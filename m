Return-Path: <apoorvsangal@gmail.com>
Message-ID: <a79669360510102327o694dffb4pcf8ead02d95c9414@mail.gmail.com>
Date: Tue, 11 Oct 2005 11:57:41 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: Mark Chambers <markc@mail.com>, Linuxppc-embedded@ozlabs.org
In-Reply-To: <003d01c5cd97$34404470$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3165_28706343.1129012061128"
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
	<20051007123126.GA6879@cathedrallabs.org>
	<a79669360510100340g2563b441w9418001c034dbe5b@mail.gmail.com>
	<003d01c5cd97$34404470$0301a8c0@chuck2>
Cc: sibi_mathew@satyam.com, vikrant_basotra@satyam.com,
	apoorv sangal <apoorv_sangal@satyam.com>
Subject: Re: Problem Regarding Ping in Linux kernel version 2.4.24
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3165_28706343.1129012061128
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I am sending the output from the console of the boot sequence and ifconfig
command as following.
Please check the same and let me know where i am going wrong.
***************************************************************************=
****************************
## Total Size =3D 0x00088c6d =3D 560237 Bytes

## Start Addr =3D 0x02000000

=3D> bootm 02000000 ## Booting image at 02000000 ...

Image Name: 2.4.24 10thOCT3

Image Type: PowerPC Linux Kernel Image (gzip compressed)

Data Size: 560173 Bytes =3D 547 kB

Load Address: 00000000

Entry Point: 00000000

Verifying Checksum ... OK

Uncompressing Kernel Image ... OK

Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb

Linux version 2.4.24-pre2 (satyam@pmcserver) (gcc version 3.2.2 20030217
(Yellow Dog Linux 3.0 3.2.2-2a_1)) #17 Mon Oct 10 15:41:43 IST 2005

On node 0 totalpages: 32768

zone(0): 32768 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200 root=3D1f00

Warning: real time clock seems stuck!

Calibrating delay loop... 131.89 BogoMIPS

Memory: 128148k available (948k kernel code, 368k data, 56k init, 0k
highmem)

Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode cache hash table entries: 8192 (order: 4, 65536 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)

Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.

Inside Chr_dev_init

CPM UART driver version 0.01

ttyS0 on SMC1 at 0x0000, BRG7

ttyS1 on SMC2 at 0x0040, BRG8

ttyS2 on SCC1 at 0x8000, BRG1

ttyS3 on SCC2 at 0x8100, BRG2

pty: 256 Unix98 ptys configured

Pty initialisation is complete

eth0: FCC2 ENET Version 0.4, 00:10:EC:40:30:8C

Inside rd_init

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

pmc8260 flash map (size->0x2000000 mem->0xFC000000)

map->buswidth : 2

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

Creating 1 MTD partitions on "pmc8260 flash memory":

0x008c0000-0x00bc0000 : "JFFS2 partition"

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 1024 buckets, 8Kbytes

TCP: Hash tables configured (established 8192 bind 16384)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

*****

VFS:test name =3D /dev/root

VFS:fs_name =3D jffs2

VFS:root name =3D 1f:00

****

jffs2_scan_inode_node(): Data CRC failed on node at 0x0003b1a8: Read
0xcd593a55, calculated 0x95474c25

jffs2_scan_inode_node(): CRC failed on node at 0x002aafc0: Read 0x00000001,
calculated 0x8ea9f6b8

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x002aafc8:
0x10e4 instead

Eep. Child "issue" (ino #127) of dir ino #4 doesn't exist!

VFS:tried fs_name =3D jffs2 err =3D 0

VFS: Mounted root (jffs2 filesystem) readonly.

Freeing unused kernel memory: 56k init 4k prep

 init started: BusyBox v0.60.5 (2004.11.09-16:07+0000) multi-call
binarymount: Mounting /dev/ram0 on /tmp failed: Invalid argument

Starting networking: done.

Starting udhcp Client: Jan 1 00:00:02 insmod: insmod: net-pf-17: no module
by that name found done.

Starting thttpd: done.

Starting OpenSSH: done.

Starting SNMP Agent: done.

jffs2_read_inode() on nonexistent ino 127

(none) login: root

Password:

Jan 1 00:00:09 login[61]: root login on `ttyS0'

BusyBox v0.60.5 (2004.11.09-16:07+0000) Built-in shell (ash)

Enter 'help' for a list of built-in commands.

# ifconfig eth0 down

# ifconfig eth0 172.19.56.218 <http://172.19.56.218>

# ifconfig eth0 up

# ifconfig

eth0 Link encap:Ethernet HWaddr 00:10:EC:40:30:8C

inet addr:172.19.56.218 <http://172.19.56.218>
Bcast:172.19.255.255<http://172.19.255.255>Mask:
255.255.0.0 <http://255.255.0.0>

UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1

RX packets:0 errors:0 dropped:0 overruns:0 frame:0

TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:1000

RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)

Base address:0x8500

lo Link encap:Local Loopback

inet addr:127.0.0.1 <http://127.0.0.1> Mask:255.0.0.0 <http://255.0.0.0>

UP LOOPBACK RUNNING MTU:16436 Metric:1

RX packets:0 errors:0 dropped:0 overruns:0 frame:0

TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:0

RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)

# ping 127.0.0.1 <http://127.0.0.1>

PING 127.0.0.1 <http://127.0.0.1> (127.0.0.1 <http://127.0.0.1>): 56 data
bytes

64 bytes from 127.0.0.1 <http://127.0.0.1>: icmp_seq=3D0 ttl=3D64 time=3D0.=
6 ms

64 bytes from 127.0.0.1 <http://127.0.0.1>: icmp_seq=3D1 ttl=3D64 time=3D0.=
2 ms

64 bytes from 127.0.0.1 <http://127.0.0.1>: icmp_seq=3D2 ttl=3D64 time=3D0.=
2 ms

64 bytes from 127.0.0.1 <http://127.0.0.1>: icmp_seq=3D3 ttl=3D64 time=3D0.=
2 ms

64 bytes from 127.0.0.1 <http://127.0.0.1>: icmp_seq=3D4 ttl=3D64 time=3D0.=
2 ms

--- 127.0.0.1 <http://127.0.0.1> ping statistics ---

5 packets transmitted, 5 packets received, 0% packet loss

round-trip min/avg/max =3D 0.2/0.2/0.6 ms

#

# ping 172.19.59.101 <http://172.19.59.101>

PING 172.19.59.101 <http://172.19.59.101>
(172.19.59.101<http://172.19.59.101>):
56 data bytes

--- 172.19.59.101 <http://172.19.59.101> ping statistics ---

6 packets transmitted, 0 packets received, 100% packet loss
***************************************************************************=
****************************
Regards,
Apoorv Sangal.

 On 10/10/05, Mark Chambers <markc@mail.com> wrote:
>
>    Hi
> Thanks for the inputs... As per your suggestion I commented
>  { mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
> but it doesn't make any diffrence, still the ping doesn't worked.
>  At Boot loader level (u-boot) Ping works fine,
>   I think you need to provide more information, because there are many
> things
> that could be wrong. Attach the output of your console from the boot
> sequence,
> and include the output of an ifconfig command if you can.
>  Mark Chambers
>
>

------=_Part_3165_28706343.1129012061128
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>I am sending the output from the console of the boot sequence and ifco=
nfig command as following.</div>
<div>Please check the same and let me know where i am going wrong.</div>
<div>**********************************************************************=
*********************************</div>
<div><font size=3D"2">## Total Size =3D 0x00088c6d =3D 560237 Bytes</font><=
/div>
<div>
<p>## Start Addr =3D 0x02000000</p>
<p>=3D&gt; bootm 02000000 ## Booting image at 02000000 ...</p>
<p>Image Name: 2.4.24 10thOCT3</p>
<p>Image Type: PowerPC Linux Kernel Image (gzip compressed)</p>
<p>Data Size: 560173 Bytes =3D 547 kB</p>
<p>Load Address: 00000000</p>
<p>Entry Point: 00000000</p>
<p>Verifying Checksum ... OK</p>
<p>Uncompressing Kernel Image ... OK</p>
<p>Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb</p>
<p>Linux version 2.4.24-pre2 (satyam@pmcserver) (gcc version 3.2.2 20030217=
 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #17 Mon Oct 10 15:41:43 IST 2005</p>
<p>On node 0 totalpages: 32768</p>
<p>zone(0): 32768 pages.</p>
<p>zone(1): 0 pages.</p>
<p>zone(2): 0 pages.</p>
<p>Kernel command line: console=3DttyS0,115200 root=3D1f00</p>
<p>Warning: real time clock seems stuck!</p>
<p>Calibrating delay loop... 131.89 BogoMIPS</p>
<p>Memory: 128148k available (948k kernel code, 368k data, 56k init, 0k hig=
hmem)</p>
<p>Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)</p>
<p>Inode cache hash table entries: 8192 (order: 4, 65536 bytes)</p>
<p>Mount cache hash table entries: 512 (order: 0, 4096 bytes)</p>
<p>Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)</p>
<p>Page-cache hash table entries: 32768 (order: 5, 131072 bytes)</p>
<p>POSIX conformance testing by UNIFIX</p>
<p>Linux NET4.0 for Linux 2.4</p>
<p>Based upon Swansea University Computer Society NET3.039</p>
<p>Initializing RT netlink socket</p>
<p>Starting kswapd</p>
<p>JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communicatio=
ns AB.</p>
<p>Inside Chr_dev_init</p>
<p>CPM UART driver version 0.01</p>
<p>ttyS0 on SMC1 at 0x0000, BRG7</p>
<p>ttyS1 on SMC2 at 0x0040, BRG8</p>
<p>ttyS2 on SCC1 at 0x8000, BRG1</p>
<p>ttyS3 on SCC2 at 0x8100, BRG2</p>
<p>pty: 256 Unix98 ptys configured</p>
<p>Pty initialisation is complete</p>
<p>eth0: FCC2 ENET Version 0.4, 00:10:EC:40:30:8C</p>
<p>Inside rd_init </p>
<p>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize</p=
>
<p>pmc8260 flash map (size-&gt;0x2000000 mem-&gt;0xFC000000)</p>
<p>map-&gt;buswidth : 2 </p>
<p>cfi_cmdset_0001: Erase suspend on write enabled</p>
<p>Using buffer write method</p>
<p>Creating 1 MTD partitions on &quot;pmc8260 flash memory&quot;:</p>
<p>0x008c0000-0x00bc0000 : &quot;JFFS2 partition&quot;</p>
<p>NET4: Linux TCP/IP 1.0 for NET4.0</p>
<p>IP Protocols: ICMP, UDP, TCP, IGMP</p>
<p>IP: routing cache hash table of 1024 buckets, 8Kbytes</p>
<p>TCP: Hash tables configured (established 8192 bind 16384)</p>
<p>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.</p>
<p>*****</p>
<p>VFS:test name =3D /dev/root</p>
<p>VFS:fs_name =3D jffs2 </p>
<p>VFS:root name =3D 1f:00</p>
<p>**** </p>
<p>jffs2_scan_inode_node(): Data CRC failed on node at 0x0003b1a8: Read 0xc=
d593a55, calculated 0x95474c25</p>
<p>jffs2_scan_inode_node(): CRC failed on node at 0x002aafc0: Read 0x000000=
01, calculated 0x8ea9f6b8</p>
<p>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x002aafc8: 0=
x10e4 instead</p>
<p>Eep. Child &quot;issue&quot; (ino #127) of dir ino #4 doesn't exist!</p>
<p>VFS:tried fs_name =3D jffs2 err =3D 0</p>
<p>VFS: Mounted root (jffs2 filesystem) readonly.</p>
<p>Freeing unused kernel memory: 56k init 4k prep</p>
<p>&nbsp;</p>
<p>init started: BusyBox v0.60.5 (2004.11.09-16:07+0000) multi-call binarym=
ount: Mounting /dev/ram0 on /tmp failed: Invalid argument</p>
<p>Starting networking: done.</p>
<p>Starting udhcp Client: Jan 1 00:00:02 insmod: insmod: net-pf-17: no modu=
le by that name found done.</p>
<p>Starting thttpd: done.</p>
<p>Starting OpenSSH: done.</p>
<p>Starting SNMP Agent: done.</p>
<p>jffs2_read_inode() on nonexistent ino 127</p>
<p>(none) login: root</p>
<p>Password: </p>
<p>Jan 1 00:00:09 login[61]: root login on `ttyS0'</p>
<p></p>
<p>BusyBox v0.60.5 (2004.11.09-16:07+0000) Built-in shell (ash)</p>
<p>Enter 'help' for a list of built-in commands.</p>
<p># ifconfig eth0 down</p>
<p># ifconfig eth0 <a href=3D"http://172.19.56.218">172.19.56.218</a> </p>
<p># ifconfig eth0 up</p>
<p># ifconfig</p>
<p>eth0 Link encap:Ethernet HWaddr 00:10:EC:40:30:8C </p>
<p>inet addr:<a href=3D"http://172.19.56.218">172.19.56.218</a> Bcast:<a hr=
ef=3D"http://172.19.255.255">172.19.255.255</a> Mask:<a href=3D"http://255.=
255.0.0">255.255.0.0</a></p>
<p>UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1</p>
<p>RX packets:0 errors:0 dropped:0 overruns:0 frame:0</p>
<p>TX packets:0 errors:0 dropped:0 overruns:0 carrier:0</p>
<p>collisions:0 txqueuelen:1000 </p>
<p>RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)</p>
<p>Base address:0x8500 </p>
<p>lo Link encap:Local Loopback </p>
<p>inet addr:<a href=3D"http://127.0.0.1">127.0.0.1</a> Mask:<a href=3D"htt=
p://255.0.0.0">255.0.0.0</a></p>
<p>UP LOOPBACK RUNNING MTU:16436 Metric:1</p>
<p>RX packets:0 errors:0 dropped:0 overruns:0 frame:0</p>
<p>TX packets:0 errors:0 dropped:0 overruns:0 carrier:0</p>
<p>collisions:0 txqueuelen:0 </p>
<p>RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)</p>
<p># ping <a href=3D"http://127.0.0.1">127.0.0.1</a></p>
<p>PING <a href=3D"http://127.0.0.1">127.0.0.1</a> (<a href=3D"http://127.0=
.0.1">127.0.0.1</a>): 56 data bytes</p>
<p>64 bytes from <a href=3D"http://127.0.0.1">127.0.0.1</a>: icmp_seq=3D0 t=
tl=3D64 time=3D0.6 ms</p>
<p>64 bytes from <a href=3D"http://127.0.0.1">127.0.0.1</a>: icmp_seq=3D1 t=
tl=3D64 time=3D0.2 ms</p>
<p>64 bytes from <a href=3D"http://127.0.0.1">127.0.0.1</a>: icmp_seq=3D2 t=
tl=3D64 time=3D0.2 ms</p>
<p>64 bytes from <a href=3D"http://127.0.0.1">127.0.0.1</a>: icmp_seq=3D3 t=
tl=3D64 time=3D0.2 ms</p>
<p>64 bytes from <a href=3D"http://127.0.0.1">127.0.0.1</a>: icmp_seq=3D4 t=
tl=3D64 time=3D0.2 ms</p>
<p>--- <a href=3D"http://127.0.0.1">127.0.0.1</a> ping statistics ---</p>
<p>5 packets transmitted, 5 packets received, 0% packet loss</p>
<p>round-trip min/avg/max =3D 0.2/0.2/0.6 ms</p>
<p># </p>
<p># ping <a href=3D"http://172.19.59.101">172.19.59.101</a></p>
<p>PING <a href=3D"http://172.19.59.101">172.19.59.101</a> (<a href=3D"http=
://172.19.59.101">172.19.59.101</a>): 56 data bytes</p>
<p>--- <a href=3D"http://172.19.59.101">172.19.59.101</a> ping statistics -=
--</p>
<p>6 packets transmitted, 0 packets received, 100% packet loss</p></div>
<div>**********************************************************************=
*********************************</div>
<div>Regards,</div>
<div>Apoorv Sangal.<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 10/10/05, <b class=3D"gmail_sendername"=
>Mark Chambers</b> &lt;<a href=3D"mailto:markc@mail.com">markc@mail.com</a>=
&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<blockquote style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5p=
x; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px"><span class=3D"q">
<div style=3D"FONT: 10pt arial">&nbsp;</div>
<div>Hi </div>
<div>Thanks for the inputs... As per your suggestion I commented </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;{ mk_m=
ii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */</div>
<div>but it doesn't make any diffrence, still the ping doesn't worked.</div=
>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div>At Boot loader level (u-boot) Ping works fine, </div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div></span>
<div><font face=3D"Arial" size=3D"2">I think you need to provide more infor=
mation, because there are many things</font></div>
<div><font face=3D"Arial" size=3D"2">that could be wrong.&nbsp; Attach the =
output of your console from the boot sequence,</font></div>
<div><font face=3D"Arial" size=3D"2">and include the output of an ifconfig =
command if you can.</font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2">Mark Chambers</font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div></blockquote></bloc=
kquote></div><br>

------=_Part_3165_28706343.1129012061128--
