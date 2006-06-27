Return-Path: <jxnuxdy@163.com>
Received: from m13-63.163.com (m13-63.163.com [220.181.13.63])
	by ozlabs.org (Postfix) with SMTP id 6FF4667A75
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 11:49:00 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44A08AEC.000113.30549@bj163app63.163.com>
Date: Tue, 27 Jun 2006 09:33:32 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: de@denx.de
Subject: Need help on ftp and telnet in my Ramdisk
References: <44A00EF4.6000109@gmail.com>
 <44A01925.9050100@ovro.caltech.edu>
In-Reply-To: <44A01925.9050100@ovro.caltech.edu>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_XXsdWaSaBASpWYOJgIVBubiujCpP"
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


--Boundary-=_XXsdWaSaBASpWYOJgIVBubiujCpP
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,
 
   1. I copied the ftp and telnet commands to my /bin, and the needed library is also copied to my /lib, but they still don't work so far, can anybody tell me why, thanks!
 
 
logs:
...
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
init started:  BusyBox v1.1.3 (2006.06.23-09:32+0000) multi-call binary
Bad inittab entry: :reth0: link is up, 100 FDX
Starting pid 23, console /dev/ttyS1: '/bin/application'
Starting pid 24, console /dev/ttyS1: '/bin/bash'
### Application running ...
bash-3.00# ]
bash: ]: command not found
bash-3.00# 
bash-3.00# 
bash-3.00# 
bash-3.00# 
bash-3.00# ftp 192.168.65.143
ftp: ftp/tcp: unknown service
bash-3.00# telnet 192.168.65.143
telnet: telnet: bad port
Starting pid 29, console /dev/ttyS1: '/bin/application'
Starting pid 30, console /dev/ttyS1: '/bin/bash'
### Application running ...
Starting pid 33, console /dev/ttyS1: '/bin/bash'
Starting pid 32, console /dev/ttyS1: '/bin/application'
### Application running ...
bash-3.00# 
 
Thanks!
- Denny
--Boundary-=_XXsdWaSaBASpWYOJgIVBubiujCpP
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; 1. I copied the ftp and telnet commands to my /bin, and=
 the needed library is also copied to my /lib, but they still don't work =
so far, can anybody tell me why, thanks!</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>logs:</DIV>
<DIV>...</DIV>
<DIV>RAMDISK: Compressed image found at block 0<BR>EXT2-fs warning: mount=
ing unchecked fs, running e2fsck is recommended<BR>VFS: Mounted root (ext=
2 filesystem).<BR>Freeing unused kernel memory: 120k init<BR>init started=
:&nbsp; BusyBox v1.1.3 (2006.06.23-09:32+0000) multi-call binary<BR>Bad i=
nittab entry: :reth0: link is up, 100 FDX<BR>Starting pid 23, console /de=
v/ttyS1: '/bin/application'<BR>Starting pid 24, console /dev/ttyS1: '/bin=
/bash'<BR>### Application running ...<BR>bash-3.00# ]<BR>bash: ]: command=
 not found<BR>bash-3.00# <BR>bash-3.00# <BR>bash-3.00# <BR>bash-3.00# <BR=
>bash-3.00# ftp 192.168.65.143<BR>ftp: ftp/tcp: unknown service<BR>bash-3=
=2E00# telnet 192.168.65.143<BR>telnet: telnet: bad port<BR>Starting pid =
29, console /dev/ttyS1: '/bin/application'<BR>Starting pid 30, console /d=
ev/ttyS1: '/bin/bash'<BR>### Application running ...<BR>Starting pid 33, =
console /dev/ttyS1: '/bin/bash'<BR>Starting pid 32, console /dev/ttyS1: '=
/bin/application'<BR>### Application running ...<BR>bash-3.00# </DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks!</DIV>
<DIV>- Denny</DIV><SPAN ></SPAN><br><!-- footer --><br><br><br><br><br><d=
iv style=3D"border-bottom:1px solid #999"></div><br>

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


--Boundary-=_XXsdWaSaBASpWYOJgIVBubiujCpP--
