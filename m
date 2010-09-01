Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id D63CBB7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 01:08:03 +1000 (EST)
Received: by pwj1 with SMTP id 1so3667437pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Sep 2010 08:08:02 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Sep 2010 20:37:53 +0530
Message-ID: <AANLkTi=_UfGNf0uHNiQAWiRjpgv8X0AbXkXkNa0ymFyD@mail.gmail.com>
Subject: PCI: device not available (can't reserve [mem 0x00000000-0x0003ffff])
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, MJ embd <mj.embd@gmail.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: multipart/alternative; boundary=0016364c5f2fd926f7048f340f0c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364c5f2fd926f7048f340f0c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am facing a strange problem with a PCI express device. I have written a
simple PCI driver(pci_skel sample driver for LDD book) just to detect a PCI
device and read its vender and device id from its configuration space. When
I connect the device on a standard i386 based PC, it works fine, as
expected. But when I run the same driver on the MPC837xERDB board(powerpc
arch based processor from freescale), it gives me error. Below is the O/P on
both the architectures. Could anyone suggest what can be the cause of this
problem? I am new to linux device driver development.

i386 output.

[  921.097050] PCI driver: Init function
[  921.097415] PCI driver: Probe function
[  921.097442] pci_skel 0000:04:00.0: PCI INT A -> GSI 18 (level, low) ->
IRQ 18
[  921.097453] PCI driver Vendor ID = 1204
[  921.097462] PCI driver Device ID = e250
[  921.097471] PCI driver Revision = 0


Powerpc output

PCI driver: Init function
PCI driver: Probe function
pci_skel 0001:02:00.0: device not available (can't reserve [mem
0x00000000-0x0003ffff])
Unable to Enable PCI device:-22
pci_skel: probe of 0001:02:00.0 failed with error -22


Thanks in advance
Ravi Gupta

--0016364c5f2fd926f7048f340f0c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am facing a strange problem with a PCI express device. I have =
written a simple PCI driver(pci_skel sample driver for LDD book) just to de=
tect a PCI device and read its vender and device id from its configuration =
space. When I connect the device on a standard i386 based PC, it works fine=
, as expected. But when I run the same driver on the MPC837xERDB board(powe=
rpc arch based processor from freescale), it gives me error. Below is the O=
/P on both the architectures. Could anyone suggest what can be the cause of=
 this problem? I am new to linux device driver development.<br>



<br>i386 output.<br><br>[=A0 921.097050] PCI driver: Init function<br>[=A0=
=20
921.097415] PCI driver: Probe function<br>[=A0 921.097442] pci_skel=20
0000:04:00.0: PCI INT A -&gt; GSI 18 (level, low) -&gt; IRQ 18<br>[=A0=20
921.097453] PCI driver Vendor ID =3D 1204<br>

[=A0 921.097462] PCI driver Device ID =3D e250<br>[=A0 921.097471] PCI driv=
er=20
Revision =3D 0<br><br><br>Powerpc output<br><br>PCI driver: Init function<b=
r>PCI
 driver: Probe function<br>pci_skel 0001:02:00.0: device not available=20
(can&#39;t reserve [mem 0x00000000-0x0003ffff])<br>

Unable to Enable PCI device:-22<br>pci_skel: probe of 0001:02:00.0=20
failed with error -22<br><br><br>Thanks in advance<br>Ravi Gupta<br>

--0016364c5f2fd926f7048f340f0c--
