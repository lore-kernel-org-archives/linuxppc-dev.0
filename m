Return-Path: <intermediadc@hotmail.com>
Received: from BLU004-OMC2S33.hotmail.com (blu004-omc2s33.hotmail.com
 [65.55.111.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ4zf1FTrzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 07:55:25 +1100 (AEDT)
From: luigi burdo <intermediadc@hotmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: PowerMac G5 Quad Strage lspci
Date: Fri, 17 Feb 2017 20:50:04 +0000
Message-ID: <AM5P194MB0129C746EB9ED2DC2F17D569C85D0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>,
 <20170217204254.GH4109@kernel.org>
In-Reply-To: <20170217204254.GH4109@kernel.org>
Content-Type: multipart/alternative;
 boundary="_000_AM5P194MB0129C746EB9ED2DC2F17D569C85D0AM5P194MB0129EURP_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_AM5P194MB0129C746EB9ED2DC2F17D569C85D0AM5P194MB0129EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all devs,

from 4.10 i have on G5 Quad this strange lspci

with this 0001:01:01.0 Non-VGA unclassified device: Device 0800:0002 (rev 0=
8)

some one know if it a bug or a new feature of the kernel.


Thanks!


My complete

lspci
0000:00:0b.0 PCI bridge: Apple Inc. CPC945 PCIe Bridge
0000:0a:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/A=
TI] Whistler LE [Radeon HD 6610M/7610M]
0000:0a:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks HDM=
I Audio [Radeon HD 6500/6600 / 6700M Series]
0001:00:00.0 Host bridge: Apple Inc. U4 HT Bridge
0001:00:01.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)
0001:00:02.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)
0001:00:03.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)
0001:00:04.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)
0001:00:05.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)
0001:00:06.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)
0001:00:07.0 PCI bridge: Apple Inc. Shasta PCI Bridge
0001:00:08.0 PCI bridge: Apple Inc. Shasta PCI Bridge
0001:00:09.0 PCI bridge: Apple Inc. Shasta PCI Bridge
0001:01:01.0 Non-VGA unclassified device: Device 0800:0002 (rev 08)
0001:01:07.0 Unassigned class [ff00]: Apple Inc. Shasta Mac I/O
0001:01:0b.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
0001:01:0b.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
0001:01:0b.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (=
rev 04)
0001:03:0c.0 IDE interface: Broadcom K2 SATA
0001:03:0d.0 Unassigned class [ff00]: Apple Inc. Shasta IDE
0001:03:0e.0 FireWire (IEEE 1394): Apple Inc. Shasta Firewire
0001:05:04.0 Ethernet controller: Broadcom Limited NetXtreme BCM5780 Gigabi=
t Ethernet (rev 03)
0001:05:04.1 Ethernet controller: Broadcom Limited NetXtreme BCM5780 Gigabi=
t Ethernet (rev 03)
0001:06:00.0 VGA compatible controller: NVIDIA Corporation G70GL [Quadro FX=
 4500] (rev a1)

Luigi


--_000_AM5P194MB0129C746EB9ED2DC2F17D569C85D0AM5P194MB0129EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi all devs,</p>
<p>from 4.10 i have on G5 Quad this strange lspci <br>
</p>
<p>with this <b>0001:01:01.0 Non-VGA unclassified device: Device 0800:0002 =
(rev 08)</b></p>
<p>some one know if it a bug or a new feature of the kernel.</p>
<p><br>
</p>
<p>Thanks!<br>
</p>
<p><br>
</p>
<p>My complete <br>
</p>
<p></p>
<div>lspci<br>
0000:00:0b.0 PCI bridge: Apple Inc. CPC945 PCIe Bridge<br>
0000:0a:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/A=
TI] Whistler LE [Radeon HD 6610M/7610M]<br>
0000:0a:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks HDM=
I Audio [Radeon HD 6500/6600 / 6700M Series]<br>
0001:00:00.0 Host bridge: Apple Inc. U4 HT Bridge<br>
0001:00:01.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)<br=
>
0001:00:02.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)<br=
>
0001:00:03.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)<br>
0001:00:04.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)<br>
0001:00:05.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)<br>
0001:00:06.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev =
a3)<br>
0001:00:07.0 PCI bridge: Apple Inc. Shasta PCI Bridge<br>
0001:00:08.0 PCI bridge: Apple Inc. Shasta PCI Bridge<br>
0001:00:09.0 PCI bridge: Apple Inc. Shasta PCI Bridge<br>
<b>0001:01:01.0 Non-VGA unclassified device: Device 0800:0002 (rev 08)</b><=
br>
0001:01:07.0 Unassigned class [ff00]: Apple Inc. Shasta Mac I/O<br>
0001:01:0b.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)<b=
r>
0001:01:0b.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)<b=
r>
0001:01:0b.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (=
rev 04)<br>
0001:03:0c.0 IDE interface: Broadcom K2 SATA<br>
0001:03:0d.0 Unassigned class [ff00]: Apple Inc. Shasta IDE<br>
0001:03:0e.0 FireWire (IEEE 1394): Apple Inc. Shasta Firewire<br>
0001:05:04.0 Ethernet controller: Broadcom Limited NetXtreme BCM5780 Gigabi=
t Ethernet (rev 03)<br>
0001:05:04.1 Ethernet controller: Broadcom Limited NetXtreme BCM5780 Gigabi=
t Ethernet (rev 03)<br>
0001:06:00.0 VGA compatible controller: NVIDIA Corporation G70GL [Quadro FX=
 4500] (rev a1)<br>
<br>
Luigi<br>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_AM5P194MB0129C746EB9ED2DC2F17D569C85D0AM5P194MB0129EURP_--
