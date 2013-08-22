Return-Path: <sarans1987@gmail.com>
Received: from mail-vb0-x231.google.com (mail-vb0-x231.google.com
 [IPv6:2607:f8b0:400c:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50BBC2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 01:34:06 +1000 (EST)
Received: by mail-vb0-f49.google.com with SMTP id w16so1359400vbb.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:34:01 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Aug 2013 21:04:01 +0530
Message-ID: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
Subject: Ethernet over PCIe driver for Inter-Processor Communication
From: Saravanan S <sarans1987@gmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=089e0149ca3aed931904e48b049f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e0149ca3aed931904e48b049f
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
          I have a custom board  with four MPC8640 nodes connected over a
transparent PCI express switch . In this configuration one node is
configured as host(Root Complex) and others as agents(End Point) .Thus the
legacy PCI software works fine . However the mainline kernel lacks any
standard support for Inter-processor communication over PCI . I am in the
process of developing an Ethernet over  PCI driver for the same on the
lines of rionet . However I am facing the following problems.

a)   I can generate MSI interrupts from End Point to Root Complex over PCI
. But the vice-versa is not possible . However i need a method to interrupt
the End Point from the Root Complex to complete my driver. Only previous
references I can find are this post
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html .
However this uses doorbells and I think may not be possible in MPC8640.

b) Also i need a method to interrupt an End Point from another end point?
Is that possible ?

Any pointers on this issue and guidance on this driver development would be
helpful .

Regards,
S.Saravanan

--089e0149ca3aed931904e48b049f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi All,<br></div>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 I have a custom board=A0 with four MPC8640 nodes connect=
ed over a transparent PCI express switch . In this configuration one node i=
s configured as host(Root Complex) and others as agents(End Point) .Thus th=
e legacy PCI software works fine . However the mainline kernel lacks any st=
andard support for Inter-processor communication over PCI . I am in the pro=
cess of developing an Ethernet over=A0 PCI driver for the same on the lines=
 of rionet . However I am facing the following problems.<br>
<br></div>a) =A0 I can generate MSI interrupts from End Point to Root Compl=
ex over PCI . But the vice-versa is not possible . However i need a method =
to interrupt the End Point from the Root Complex to complete my driver. Onl=
y previous references I can find are this post <a href=3D"http://www.mail-a=
rchive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html">http://www.mail-arc=
hive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html</a> . However this use=
s doorbells and I think may not be possible in MPC8640.<br>
<br></div>b) Also i need a method to interrupt an End Point from another en=
d point? Is that possible ?<br><br></div>Any pointers on this issue and gui=
dance on this driver development would be helpful . <br><br></div>Regards,<=
br>
</div>S.Saravanan<br></div>

--089e0149ca3aed931904e48b049f--
