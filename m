Return-Path: <jxnuxdy@163.com>
Received: from m13-14.163.com (m13-14.163.com [220.181.13.14])
	by ozlabs.org (Postfix) with SMTP id B2E2767BA9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 17:03:08 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44C07C29.000091.20211@bj163app14.163.com>
Date: Fri, 21 Jul 2006 15:03:05 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: linuxppc-embedded@ozlabs.org
Subject: Can't "up" my eth0
References: <44A00EF4.6000109@gmail.com> <44A01925.9050100@ovro.caltech.edu>
	<44A08AEC.000113.30549@bj163app63.163.com>
	<1151373673.26257.194.camel@mindpipe>
In-Reply-To: <1151373673.26257.194.camel@mindpipe>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_OWogomYSdSLyaCcgpINPjEfeGuxl"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_OWogomYSdSLyaCcgpINPjEfeGuxl
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,
 
   I am now succefully to bring up my kernel on my PPC440GP custom board, but I failed to up my eth0, the eth0 is link down after the kernel is booting up.
   
   There is no effect, after the command ifconfig eth0 up.
   
   Can anyone tell me what may be the root case, and what reason may cause the eth0 unstable, thanks a lot.
 
    below is my log:
PPC 4xx OCP EMAC driver, version 3.53
mal0: initialized, 4 TX channels, 2 RX channels
zmii0: bridge in RMII mode
eth0: emac0, MAC 00:01:02:54:12:47
eth0: found Generic MII PHY (0x01)
emac1: can't find PHY!
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
Starting pid 22, console /dev/teth0: link is down
Starting pid 27, console /dev/ttyS1: '/bin/bash'
Starting pid 26, console /dev/ttyS1: '/bin/application'
### Application running ...
Starting pid 29, console /dev/ttyS1: '/bin/application'
 
Thanks in advance!
- Denny
 
 
 
--Boundary-=_OWogomYSdSLyaCcgpINPjEfeGuxl
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; I am now succefully to bring up my kernel on my PPC440G=
P custom board, but I failed to up my eth0, the eth0 is link down after t=
he kernel is booting up.</DIV>
<DIV>&nbsp;&nbsp; </DIV>
<DIV>&nbsp;&nbsp; There is no effect, after the command ifconfig eth0 up.=
</DIV>
<DIV>&nbsp;&nbsp;&nbsp;</DIV>
<DIV>&nbsp;&nbsp; Can anyone tell me what may be the root case, and what =
reason may cause the eth0 unstable, thanks a lot.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; below is my log:</DIV>
<DIV>PPC 4xx OCP EMAC driver, version 3.53<BR>mal0: initialized, 4 TX cha=
nnels, 2 RX channels<BR>zmii0: bridge in RMII mode<BR>eth0: emac0, MAC 00=
:01:02:54:12:47<BR>eth0: found Generic MII PHY (0x01)<BR>emac1: can't fin=
d PHY!<BR>mice: PS/2 mouse device common for all mice<BR>NET: Registered =
protocol family 2<BR>IP route cache hash table entries: 4096 (order: 2, 1=
6384 bytes)<BR>TCP established hash table entries: 16384 (order: 4, 65536=
 bytes)<BR>TCP bind hash table entries: 16384 (order: 4, 65536 bytes)<BR>=
TCP: Hash tables configured (established 16384 bind 16384)<BR>TCP reno re=
gistered<BR>TCP bic registered<BR>NET: Registered protocol family 1<BR>NE=
T: Registered protocol family 17<BR>RAMDISK: Compressed image found at bl=
ock 0<BR>EXT2-fs warning: mounting unchecked fs, running e2fsck is recomm=
ended<BR>VFS: Mounted root (ext2 filesystem).<BR>Freeing unused kernel me=
mory: 120k init<BR>Starting pid 22, console /dev/teth0: link is down<BR>S=
tarting pid 27, console /dev/ttyS1: '/bin/bash'<BR>Starting pid 26, conso=
le /dev/ttyS1: '/bin/application'<BR>### Application running ...<BR>Start=
ing pid 29, console /dev/ttyS1: '/bin/application'</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in advance!</DIV>
<DIV>- Denny</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV><SPAN ></SPAN><br><!-- footer --><br><br><br><br><br><di=
v style=3D"border-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=CF=EB =D2=AA =CC=E5 =
=D1=E9 =D2=BB =CF=C2 =B3=AC =B4=F3 =B3=AC =BF=EC =B5=C4 =C3=E2 =B7=D1 =D3=
=CA =CF=E4 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=CD=F8 =D2=D7 3G =C3=E2 =B7=D1 =D3=CA =A3=
=AC=C7=C0 =D7=A2 =D4=D9 =B5=C3 280 =D5=D7 =B4=F3 =C8=DD =C1=BF =CD=F8 =C5=
=CC =A3=AC=BF=EC =C0=B4 =CC=E5 =D1=E9 =D3=CA =CF=E4 =BC=AB =CB=D9 =D6=AE =
=C2=C3
</a>


--Boundary-=_OWogomYSdSLyaCcgpINPjEfeGuxl--
