Return-Path: <sridhar_a@yahoo.com>
Received: from nm16-vm1.bullet.mail.ne1.yahoo.com
 (nm16-vm1.bullet.mail.ne1.yahoo.com [98.138.91.47])
 by ozlabs.org (Postfix) with SMTP id 9022CB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 16:34:17 +1100 (EST)
Message-ID: <1327383250.37748.YahooMailNeo@web120206.mail.ne1.yahoo.com>
Date: Mon, 23 Jan 2012 21:34:10 -0800 (PST)
From: Sridhar Addagada <sridhar_a@yahoo.com>
Subject: arch/powerpc/platforms/83xx/misc.c
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="121646022-206359311-1327383250=:37748"
Reply-To: Sridhar Addagada <sridhar_a@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--121646022-206359311-1327383250=:37748
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I have a hang problem on my board based on MPC8377EWLAN, here is how i ran =
into problem. We are using u-boot to load the kernel, rootfs and device tre=
e.=A0 The kernel parameters have been set =0A=0A=0Aroot=3D/dev/ram rw rootf=
stype=3Dext2 ramdisk_size=3D131322 console=3DttyS0,115200=0A=0Abut I load t=
he rootfs image generated of rootfs.jffs2 (we use buildroot), which results=
 in kernel spitting the following message and hang.=A0 I even enabled the W=
DT (mpc83xx_wdt.c) the board does not get reset.=0A=0AAny ideas would be ap=
preciated.=0A=0AThanks=0ASridhar=0A=0A=0A=0ATCP cubic registered=0AInitiali=
zing XFRM netlink socket=0ANET: Registered protocol family 17=0ANET: Regist=
ered protocol family 15=0A8021q: 802.1Q VLAN Support v1.8=0Alib80211: commo=
n routines for IEEE802.11 drivers=0ARegistering the dns_resolver key type=
=0Artc-m41t80 0-0068: setting system clock to 2012-01-23 20:32:26 UTC (1327=
350746)=0ARAMDISK: Couldn't find valid RAM disk image starting at 0.=0AList=
 of all partitions:=0A1f00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 512 mtdblock=
0=A0 (driver?)=0A1f01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 128 mtdblock1=A0 =
(driver?)=0A1f02=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5120 mtdblock2=A0 (driver=
?)=0A1f03=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10240 mtdblock3=A0 (driver?)=0A1f04=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 128 mtdblock4=A0 (driver?)=0A1f05=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5120 mtdblock5=A0 (driver?)=0A1f06=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 10240 mtdblock6=A0 (driver?)=0A1f07=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 128 mtdblock7=A0 (driver?)=0A1f08=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 128 mtdblock8=A0 (driver?)=0A1f09=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 99328 mtdblock9=A0 (driver?)=0ANo filesystem could mount root, tried=
:=A0 ext2 squashfs=0AKernel panic - not syncing: VFS: Unable to mount root =
fs on unknown-block(1,0)=0ACall Trace:=0A[cf82bef0] [c0007fa0] show_stack+0=
x4c/0x144 (unreliable)=0A[cf82bf30] [c02e8074] panic+0xac/0x1f8=0A[cf82bf80=
] [c03c3df0] mount_block_root+0x288/0x2ac=0A[cf82bfc0] [c03c401c] prepare_n=
amespace+0x1a0/0x1ec=0A[cf82bfe0] [c03c3248] kernel_init+0x114/0x130=0A[cf8=
2bff0] [c000d768] kernel_thread+0x4c/0x68=0ARebooting in 180 seconds..
--121646022-206359311-1327383250=:37748
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:10pt"><div>I ha=
ve a hang problem on my board based on MPC8377EWLAN, here is how i ran into=
 problem. We are using u-boot to load the kernel, rootfs and device tree.&n=
bsp; The kernel parameters have been set <br></div><div><br></div><div>root=
=3D/dev/ram rw rootfstype=3Dext2 ramdisk_size=3D131322 console=3DttyS0,1152=
00</div><div><br></div><div>but I load the rootfs image generated of rootfs=
.jffs2 (we use buildroot), which results in kernel spitting the following m=
essage and hang.&nbsp; I even enabled the WDT (mpc83xx_wdt.c) the board doe=
s not get reset.</div><div><br></div><div>Any ideas would be appreciated.</=
div><div><br></div><div>Thanks</div><div>Sridhar<br></div><div><br></div><d=
iv><br></div><div>TCP cubic registered<br>Initializing XFRM netlink socket<=
br>NET: Registered protocol family 17<br>NET: Registered protocol family
 15<br>8021q: 802.1Q VLAN Support v1.8<br>lib80211: common routines for IEE=
E802.11 drivers<br>Registering the dns_resolver key type<br>rtc-m41t80 0-00=
68: setting system clock to 2012-01-23 20:32:26 UTC (1327350746)<br>RAMDISK=
: Couldn't find valid RAM disk image starting at 0.<br>List of all partitio=
ns:<br>1f00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 512 mtdblock0&nbsp; (driver?)<br>1f01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128 mtdblock1&nbsp; (driver?)<b=
r>1f02&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51=
20 mtdblock2&nbsp; (driver?)<br>1f03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 10240 mtdblock3&nbsp; (driver?)<br>1f04&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128 mtdblock4&nb=
sp; (driver?)<br>1f05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 5120 mtdblock5&nbsp;
 (driver?)<br>1f06&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 10240 mtdblock6&nbsp; (driver?)<br>1f07&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128 mtdblock7&nbsp; (driver?)<br>1=
f08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 128 mtdblock8&nbsp; (driver?)<br>1f09&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 99328 mtdblock9&nbsp; (driver?)<br>No filesystem co=
uld mount root, tried:&nbsp; ext2 squashfs<br>Kernel panic - not syncing: V=
FS: Unable to mount root fs on unknown-block(1,0)<br>Call Trace:<br>[cf82be=
f0] [c0007fa0] show_stack+0x4c/0x144 (unreliable)<br>[cf82bf30] [c02e8074] =
panic+0xac/0x1f8<br>[cf82bf80] [c03c3df0] mount_block_root+0x288/0x2ac<br>[=
cf82bfc0] [c03c401c] prepare_namespace+0x1a0/0x1ec<br>[cf82bfe0] [c03c3248]=
 kernel_init+0x114/0x130<br>[cf82bff0] [c000d768] kernel_thread+0x4c/0x68<b=
r>Rebooting in 180
 seconds..<br></div><div><br></div></div></body></html>
--121646022-206359311-1327383250=:37748--
