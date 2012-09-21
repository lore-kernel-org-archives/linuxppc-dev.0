Return-Path: <zinosat@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8FD72C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 21:33:42 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so7331676pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 04:33:40 -0700 (PDT)
MIME-Version: 1.0
Sender: zinosat@gmail.com
Date: Fri, 21 Sep 2012 13:33:40 +0200
Message-ID: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
Subject: PCI device not working
From: Davide Viti <zinosat@tiscali.it>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7b339c838adf9704ca349c77
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b339c838adf9704ca349c77
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm working on a custom board based on P1020 with two (identical) PCI
devices attached;
The work is derived from another board with a single instance of that
device.
The system is based on u-boot-2009.11 and Linux 2.6.34.6

The "pci" command on u-boot, shows me both the PCI controllers and
the attached devices:

Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1957     0x0100     Processor               0x20

Scanning PCI devices on bus 1
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
01.00.00   0x1b65     0xabba     Network controller      0x80

Scanning PCI devices on bus 2
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
02.00.00   0x1957     0x0100     Processor               0x20

Scanning PCI devices on bus 3
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
03.00.00   0x1b65     0xabba     Network controller      0x80

The kernel detects only the first instance of the device.

Didn't get very far while looking at dts file and kernel logs, so I'm
asking for some help on narrowing down the problem.

I'm wondering if I can assume that the problem is restricted to
kernel/dts and avoid concentrating on uboot.
I can provide any log (didn't want to post tons of details on the first
message)

Thanx in advance for your help,
regards

Davide

--047d7b339c838adf9704ca349c77
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div>I&#39;m working on a custom board based on P1020 with tw=
o (identical) PCI devices attached;</div><div>The work is derived from anot=
her board with a single instance of that device.</div><div>The system is ba=
sed on u-boot-2009.11 and Linux 2.6.34.6</div>
<div><br></div><div>The &quot;pci&quot; command on u-boot, shows me both th=
e PCI controllers and</div><div>the attached devices:</div><div><br></div><=
div>Scanning PCI devices on bus 0</div><div>BusDevFun =A0VendorId =A0 Devic=
eId =A0 Device Class =A0 =A0 =A0 Sub-Class</div>
<div>_____________________________________________________________</div><di=
v>00.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0x20</div><div><br></div><div>Scanning PCI devices on bus 1</div><d=
iv>BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Clas=
s</div>
<div>_____________________________________________________________</div><di=
v>01.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0 =A0 =A0=
0x80</div><div><br></div><div>Scanning PCI devices on bus 2</div><div>BusDe=
vFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Class</div>
<div>_____________________________________________________________</div><di=
v>02.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0x20</div><div><br></div><div>Scanning PCI devices on bus 3</div><d=
iv>BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Clas=
s</div>
<div>_____________________________________________________________</div><di=
v>03.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0 =A0 =A0=
0x80</div><div><br></div><div>The kernel detects only the first instance of=
 the device.</div>
<div><br></div><div>Didn&#39;t get very far while looking at dts file and k=
ernel logs, so I&#39;m</div><div>asking for some help on narrowing down the=
 problem.</div><div><br></div><div>I&#39;m wondering if I can assume that t=
he problem is restricted to</div>
<div>kernel/dts and avoid concentrating on uboot.=A0</div><div>I can provid=
e any log (didn&#39;t want to post tons of details on the first=A0</div><di=
v>message)</div><div><br></div><div>Thanx in advance for your help,</div><d=
iv>
regards</div><div><br></div><div>Davide</div>

--047d7b339c838adf9704ca349c77--
