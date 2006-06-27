Return-Path: <jxnuxdy@163.com>
Received: from m13-63.163.com (m13-63.163.com [220.181.13.63])
	by ozlabs.org (Postfix) with SMTP id 517F967A5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 11:56:15 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44A08BA0.000020.01911@bj163app63.163.com>
Date: Tue, 27 Jun 2006 09:36:32 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: de@denx.de
Subject: Need help on adding a command to my ramdi
 sk
References: <44A00EF4.6000109@gmail.com> <44A01925.9050100@ovro.caltech.edu>
	<44A08AEC.000113.30549@bj163app63.163.com>
In-Reply-To: <44A08AEC.000113.30549@bj163app63.163.com>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_bjAvpuCZTsXOIKzIxZyBBbQWzdpJ"
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


--Boundary-=_bjAvpuCZTsXOIKzIxZyBBbQWzdpJ
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi, 
 
   Since there is no "ldd" command in busybox1.1.3, so I copied it from ELDK4.0 to my bin,
but it didn't work, can anybody tell me how to add a new command to my ramdisk ?
 
bash-3.00# ldd /bin/ftp
sh: applet not found
bash-3.00# 
 
 
- Denny
 
 
 
--Boundary-=_bjAvpuCZTsXOIKzIxZyBBbQWzdpJ
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi, </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; Since there is no "ldd" command in busybox1.1.3, so I c=
opied it from ELDK4.0 to my bin,</DIV>
<DIV>but it didn't work, can anybody tell me how to add a new command to =
my ramdisk ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>bash-3.00# ldd /bin/ftp<BR>sh: applet not found<BR>bash-3.00# </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>- Denny</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
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


--Boundary-=_bjAvpuCZTsXOIKzIxZyBBbQWzdpJ--
