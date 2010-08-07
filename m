Return-Path: <vivek_av@yahoo.com>
Received: from web55505.mail.re4.yahoo.com (web55505.mail.re4.yahoo.com
	[206.190.58.214]) by ozlabs.org (Postfix) with SMTP id CD7D6B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Aug 2010 02:06:36 +1000 (EST)
Message-ID: <307394.74573.qm@web55505.mail.re4.yahoo.com>
Date: Sat, 7 Aug 2010 09:06:34 -0700 (PDT)
From: vivek <vivek_av@yahoo.com>
Subject: PLX9030 port
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-687035471-1281197194=:74573"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-687035471-1281197194=:74573
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all
I am new to the mail list

I am trying to port the driver for PLX9030 PCI host chip based add-on card =
from=A0 x86=A0 to PPC7410 arch

the following function function returns NULL
pci_get_device(0x10b5, 0x9030, NULL)

vendor ID given for PLX is 0x10b5
device ID is 0x9030

These values worked=A0 and the module found the device in x86 platform,

But the same code is complied and inserted on PPC7410 platform, the modules=
 failed to detect the device

Is there any Endianness conversion to be performed before passing the value=
s to pci_get_device()=A0 in hex format ?
=A0
I am using linux 2.6.24 kernel and=20
while make-ing=A0 the module ,ko file for PPC7410 using cross_complier gcc_=
74xx-
there was a WARNING message "struct_module undefined "
But it is possible to insert the module in the=A0 kernel running on PPC7410=
, which then printk 's the message when pci_get_device() returns NULL

can anyone help?
thnaks --vivek
=0A=0A=0A      
--0-687035471-1281197194=:74573
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hello all<br>I am new to the mail list<br><br=
>I am trying to port the driver for PLX9030 PCI host chip based add-on card=
 from&nbsp; x86&nbsp; to PPC7410 arch<br><br>the following function functio=
n returns NULL<br><a href=3D"http://tomoyo.sourceforge.jp/cgi-bin/lxr/ident=
?a=3Dppc;i=3Dpci_get_device">pci_get_device</a>(<span style=3D"text-decorat=
ion: underline;">0x10b5</span><a href=3D"http://tomoyo.sourceforge.jp/cgi-b=
in/lxr/ident?a=3Dppc;i=3Dvendor"></a>, <span style=3D"text-decoration: unde=
rline;">0x9030</span><a href=3D"http://tomoyo.sourceforge.jp/cgi-bin/lxr/id=
ent?a=3Dppc;i=3Ddevice"></a>, NULL)<br><br>vendor ID given for PLX is 0x10b=
5<br>device ID is 0x9030<br><br>These values worked&nbsp; and the module fo=
und the device in x86 platform,<br><br>But the same code is complied and in=
serted on PPC7410 platform, the modules failed to detect the device<br><br>=
Is there any Endianness
 conversion to be performed before passing the values to pci_get_device()&n=
bsp; in hex format ?<br>&nbsp;<br>I am using linux 2.6.24 kernel and <br>wh=
ile make-ing&nbsp; the module ,ko file for PPC7410 using cross_complier gcc=
_74xx-<br>there was a WARNING message "struct_module undefined "<br>But it =
is possible to insert the module in the&nbsp; kernel running on PPC7410, wh=
ich then printk 's the message when pci_get_device() returns NULL<br><br>ca=
n anyone help?<br>thnaks --vivek<br></td></tr></table><br>=0A=0A      
--0-687035471-1281197194=:74573--
