Return-Path: <alancarbr@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id 8FF2F688D0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 00:18:17 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i2so902998wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Dec 2005 05:18:16 -0800 (PST)
Message-ID: <dc70db7d0512080518r674f4025s8e52302e0d3f4249@mail.gmail.com>
Date: Thu, 8 Dec 2005 11:18:15 -0200
From: Alan Carvalho <alancarbr@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051206203343.67682353F5E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12655_5309769.1134047895572"
References: <dc70db7d0512060906y7fa62c56q4c25dd5d92b2b2dd@mail.gmail.com>
	<20051206203343.67682353F5E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_12655_5309769.1134047895572
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Denx,

I still doing some tests with ATI Video cards, as I said before the card
work fine on my PC.

I compiled the 2.6.14 kernel to Lite5200 with /proc/pci support, then when =
I
execute:

/ # cat /proc/pci
PCI devices found:
  Bus  0, device  26, function  0:
    Class 0680: PCI device 1057:5803 (rev 0).
      Master Capable.  Latency=3D248.
      Non-prefetchable 32 bit memory at 0xa0000000 [0xa003ffff].
/ #

It don't list the card placed at PCI slot, on PC using "lspci -v" I see:

0000:00:0c.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M (rev 64) (prog-if 00 [VGA])
        Subsystem: 1002:4c52
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 10
        Memory at ed000000 (32-bit, non-prefetchable) [size=3D16M]
        I/O ports at d800 [size=3D256]
        Memory at ec800000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at 20000000 [disabled] [size=3D128K]
        Capabilities: [5c] Power Management version 1

What you think?
Is it normal Linux on Lite5200 don't show the PCI card info?

I am looking for an "ATI Rage XL Xpert98" because Linux kernel has support
to initialize it without BIOS help (CONFIG_FB_ATY_XL_INIT).
I see some post at some list from people using this board on no x86
platform.

Cheers,

Alan

------=_Part_12655_5309769.1134047895572
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Denx,<br><br>
I still doing some tests with ATI Video cards, as I said before the card wo=
rk fine on my PC.<br>
<br>
I compiled the 2.6.14 kernel to Lite5200 with /proc/pci support, then when =
I execute:<br>
<br>
/ # cat /proc/pci<br>
PCI devices found:<br>
&nbsp; Bus&nbsp; 0, device&nbsp; 26, function&nbsp; 0:<br>
&nbsp;&nbsp;&nbsp; Class 0680: PCI device 1057:5803 (rev 0).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Master Capable.&nbsp; Latency=3D248.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-prefetchable 32 bit memory at 0xa0000000=
 [0xa003ffff].<br>
/ #<br>
<br>
It don't list the card placed at PCI slot, on PC using &quot;lspci -v&quot;=
 I see:<br>
<br>
0000:00:0c.0 VGA compatible controller: ATI Technologies Inc Rage Mobility =
P/M (rev 64) (prog-if 00 [VGA])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1002:4c52<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, stepping, med=
ium devsel, latency 32, IRQ 10<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at ed000000 (32-bit, non-=
prefetchable) [size=3D16M]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at d800 [size=3D256]<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at ec800000 (32-bit, non-=
prefetchable) [size=3D4K]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Expansion ROM at 20000000 [disab=
led] [size=3D128K]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [5c] Power Managem=
ent version 1<br>
<br>
What you think? <br>
Is it normal Linux on Lite5200 don't show the PCI card info?<br>
<br>
I am looking for an &quot;ATI Rage XL Xpert98&quot; because Linux kernel ha=
s
support to initialize it without BIOS help (CONFIG_FB_ATY_XL_INIT). <br>
I see some post at some list from people using this board on no x86 platfor=
m.<br>
<br>
Cheers,<br>
<br>
Alan<br>
<br>

------=_Part_12655_5309769.1134047895572--
