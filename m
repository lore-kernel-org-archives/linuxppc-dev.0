To: linuxppc-dev@lists.linuxppc.org
Subject: orinoco_cs on linuxppc_2_4/linux-2.4-benh
From: Josh Huber <huber@alum.wpi.edu>
Date: Thu, 17 Jan 2002 21:38:10 -0500
Message-ID: <87ofjs8ju5.fsf@paradoxical.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've decided to update the kernel on my laptop (Lombard 400),
currently it's running 2.4.11-pre4-ben0, which seems to work fine,
except I can't get usbmidi working with it.

usbmidi works (afaict) with the current 2.4.18-pre4(-ben0)? trees from
either linuxppc_2_4 or Ben's tree.  However, both of them seem to
break my wireless card.  The link to the base (an airport) appears to
be good, however no packets are transmitted/received over the link:

with the newer kernels:

iwconfig:
eth1      IEEE 802.11-DS  ESSID:"huber_net"  Nickname:"mystic"
          Mode:Managed  Frequency:2.412GHz  Access Point: 00:60:1D:1D:3E:0E
          Bit Rate:1Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry limit:4   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality:15/92  Signal level:-74 dBm  Noise level:-89 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

dmesg:
hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.09a (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.09 (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0004:0034
eth1: Looks like a Lucent/Agere firmware version 4.52
eth1: Ad-hoc demo mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:60:1D:F1:04:67
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 22, io 0x0100-0x013f


Anyone else have this working with current kernels?

with the older kernel:

iwconfig:
eth1      IEEE 802.11-DS  ESSID:"huber_net"  Nickname:"mystic"
          Mode:Managed  Frequency:2.412GHz  Access Point: 00:60:1D:1D:3E:0E
          Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry limit:4   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off

dmesg:
hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.08 (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.08 (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0004:0034
eth1: Looks like a Lucent/Agere firmware version 4.52
eth1: Ad-hoc demo mode supported.
eth1: WEP supported, "128"-bit key.
eth1: MAC address 00:60:1D:F1:04:67
eth1: Station name "HERMES I"
eth1: Allowed channels mask: 0x000007ff
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 22, io 0x0100-0x013f


If you need any more info, just ask,

--
Josh Huber

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
