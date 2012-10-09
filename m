Return-Path: <b.romanous@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13F232C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2012 18:39:02 +1100 (EST)
Received: by mail-lb0-f179.google.com with SMTP id c1so3100824lbg.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2012 00:38:54 -0700 (PDT)
MIME-Version: 1.0
From: Bashar Romanous <b.romanous@gmail.com>
Date: Tue, 9 Oct 2012 10:38:34 +0300
Message-ID: <CAO2nRsvfec4-6+eVZhS63j473jT10fe9wjpScUpA2bdknsbLRQ@mail.gmail.com>
Subject: support for Xilinx PCIe BUS IP core
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d04016d5b1c970204cb9b6e20
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04016d5b1c970204cb9b6e20
Content-Type: text/plain; charset=ISO-8859-1

Dear All,

This is the first thread in the list, I'm working on research project that
requires me to have "PCI Express Bus Support" for Xilinx FPGA board
ML605 running PetaLinux (kernel 2.6.37.6) on MicroBlaze. I'm using Xilinx
soft IP core "PLB2PCIe bridge" configured as Root Complex. the problem is
that on the Linux Kernel side, in the "Bus Options", there is no support
for Xilinx PCIe Bus.

Has anybody written Linux Driver for this IP core? what about Xilinx' (*AXI
RC*/*EP* Bridge for *PCI Express)? any drivers for this?*

Best Regards,
Bashar

--f46d04016d5b1c970204cb9b6e20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"tahoma,sans-serif">Dear All,</font><div><fon=
t face=3D"tahoma,sans-serif"><br></font></div><div><font face=3D"tahoma,san=
s-serif">This is the first thread in the list, I&#39;m working on research =
project that requires me=A0to have &quot;PCI Express Bus Support&quot; for =
Xilinx FPGA board</font></div>

<div><font face=3D"tahoma,sans-serif">ML605 running PetaLinux (kernel 2.6.3=
7.6) on MicroBlaze. I&#39;m</font><font face=3D"tahoma,sans-serif">=A0using=
=A0</font><span style=3D"background-color:rgb(255,255,255)"><font color=3D"=
#222222" face=3D"arial, helvetica, sans-serif"><span style=3D"line-height:1=
9px">Xilinx soft IP core &quot;PLB2PCIe bridge&quot; configured as Root Com=
plex. the problem is that on the Linux Kernel side, in the &quot;Bus Option=
s&quot;, there is no support for=A0Xilinx=A0PCIe Bus.</span></font></span><=
/div>

<div><br></div><div><font color=3D"#222222" face=3D"arial, helvetica, sans-=
serif"><span style=3D"line-height:19px">Has anybody written Linux Driver fo=
r this IP core? what about Xilinx&#39; (</span></font><em style=3D"color:rg=
b(34,34,34);font-family:arial,sans-serif;white-space:nowrap;font-style:norm=
al">AXI RC</em><span style=3D"background-color:rgb(255,255,255);color:rgb(3=
4,34,34);font-family:arial,sans-serif;white-space:nowrap">/</span><em style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;white-space:nowrap;fon=
t-style:normal">EP</em><span style=3D"background-color:rgb(255,255,255);col=
or:rgb(34,34,34);font-family:arial,sans-serif;white-space:nowrap">=A0</span=
><span style=3D"background-color:rgb(255,255,255);color:rgb(34,34,34);font-=
family:arial,sans-serif;white-space:nowrap">Bridge for</span><span style=3D=
"background-color:rgb(255,255,255);color:rgb(34,34,34);font-family:arial,sa=
ns-serif;white-space:nowrap">=A0</span><em style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;white-space:nowrap;font-style:normal">PCI Express=
)? any drivers for this?</em></div>

<div><div dir=3D"ltr"><div><br></div>Best Regards,<div>Bashar</div></div><b=
r>
</div></div>

--f46d04016d5b1c970204cb9b6e20--
