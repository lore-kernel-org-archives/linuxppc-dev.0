Return-Path: <hangtoo@163.com>
Received: from m5-81.163.com (m5-81.163.com [202.108.5.81])
	by ozlabs.org (Postfix) with SMTP id BB9AA67C30
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 20:06:36 +1000 (EST)
Date: Mon, 16 Oct 2006 17:51:33 +0800
From: "tony" <hangtoo@163.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: pci-usb card problem
Message-ID: <200610161751272186329@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon614514446686_====="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon614514446686_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

hi,all
    I got a pci to usb card problem this days.
    env: linux-2.6.17,ppc405ep,bubinga board
    problem: 
        during boot time,an error show up like this
        Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 8MiB 1,8V 8-bit":
0x00000000-0x00800000 : "NAND simulator partition"
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 29, io mem 0xbfffff00
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc3 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:02.0: UHCI Host Controller
uhci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:02.0: detected 2 ports
uhci_hcd 0000:00:02.0: irq 29, io base 0x0000ffe0
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:02.1: UHCI Host Controller
uhci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:02.1: detected 2 ports
uhci_hcd 0000:00:02.1: irq 29, io base 0x0000ffc0
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-3: new high speed USB device using ehci_hcd and address 2
usb 1-3: configuration #1 chosen from 1 choice
ub(1.2): GetMaxLUN returned 0, using 1 LUNs
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: C0170314 CTR: 00000000
REGS: c030bd40 TRAP: 0400   Not tainted  (2.6.17-rc3)
MSR: 00021030 <ME,IR,DR>  CR: 42004024  XER: 20000000
TASK = c02c78f8[0] 'swapper' THREAD: c030a000
GPR00: 00000000 C030BDF0 C02C78F8 C75CE800 C75D0A00 00000000 00000008 00000008 
GPR08: 00000001 00000000 C75D0A00 C75CE854 22004082 00000000 07FF7F00 00000000 
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 07FF2B4C 00000000 C75CE9D4 C016F5C0 
GPR24: 00029030 00000000 C75CE960 C75CE9F4 C75CE978 C0330000 00000000 C75CE800 
Call Trace:
[C030BDF0] [C0330000]  (unreliable)
[C030BE10] [C01704C8] 
[C030BE40] [C001F734] 
[C030BE60] [C001F908] 
[C030BE90] [C0007CC0] 
[C030BEA0] [C001F638] 
[C030BEB0] [C0007C1C] 
[C030BED0] [C00032F8] 
[C030BF90] [C000A6B0] 
[C030BFB0] [C0002358] 
[C030BFC0] [C030C694] 
[C030BFF0] [C0002254] 
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 1 seconds.. 

rarely,it can boot successfully,shows:
Initializing USB Mass Storage driver...
usb 1-3: new high speed USB device using ehci_hcd and address 2
usb 1-3: Product: USBFlash
usb 1-3: Manufacturer: Generic 
usb 1-3: configuration #1 chosen from 1 choice
ub(1.2): Unable to submit GetMaxLUN (-22)  
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
TCP bic registered

I have tried to configure kernel many times...but the problem still exists....
any advise is appreciated.


tony

--=====003_Dragon614514446686_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2180" name=GENERATOR></HEAD>
<BODY>
<DIV>hi,all</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I got a pci to usb card problem this days.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; env: linux-2.6.17,ppc405ep,bubinga board</DIV>
<DIV>&nbsp;&nbsp;&nbsp; problem: </DIV>
<DIV>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; during boot time,an error show up 
like this</DIV>
<DIV>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Scanning device for bad 
blocks<BR>Creating 1 MTD partitions on "NAND 8MiB 1,8V 
8-bit":<BR>0x00000000-0x00800000 : "NAND simulator partition"<BR>ehci_hcd 
0000:00:02.2: EHCI Host Controller<BR>ehci_hcd 0000:00:02.2: new USB bus 
registered, assigned bus number 1<BR>ehci_hcd 0000:00:02.2: irq 29, io mem 
0xbfffff00<BR>ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 
2004<BR>usb usb1: Product: EHCI Host Controller<BR>usb usb1: Manufacturer: Linux 
2.6.17-rc3 ehci_hcd<BR>usb usb1: SerialNumber: 0000:00:02.2<BR>usb usb1: 
configuration #1 chosen from 1 choice<BR>hub 1-0:1.0: USB hub found<BR>hub 
1-0:1.0: 4 ports detected<BR>USB Universal Host Controller Interface driver 
v3.0<BR>uhci_hcd 0000:00:02.0: UHCI Host Controller<BR>uhci_hcd 0000:00:02.0: 
new USB bus registered, assigned bus number 2<BR>uhci_hcd 0000:00:02.0: detected 
2 ports<BR>uhci_hcd 0000:00:02.0: irq 29, io base 0x0000ffe0<BR>usb usb2: 
Product: UHCI Host Controller<BR>usb usb2: Manufacturer: Linux 2.6.17-rc3 
uhci_hcd<BR>usb usb2: SerialNumber: 0000:00:02.0<BR>usb usb2: configuration #1 
chosen from 1 choice<BR>hub 2-0:1.0: USB hub found<BR>hub 2-0:1.0: 2 ports 
detected<BR>uhci_hcd 0000:00:02.1: UHCI Host Controller<BR>uhci_hcd 
0000:00:02.1: new USB bus registered, assigned bus number 3<BR>uhci_hcd 
0000:00:02.1: detected 2 ports<BR>uhci_hcd 0000:00:02.1: irq 29, io base 
0x0000ffc0<BR>usb usb3: Product: UHCI Host Controller<BR>usb usb3: Manufacturer: 
Linux 2.6.17-rc3 uhci_hcd<BR>usb usb3: SerialNumber: 0000:00:02.1<BR>usb usb3: 
configuration #1 chosen from 1 choice<BR>hub 3-0:1.0: USB hub found<BR>hub 
3-0:1.0: 2 ports detected<BR>Initializing USB Mass Storage driver...<BR>usb 1-3: 
new high speed USB device using ehci_hcd and address 2<BR>usb 1-3: configuration 
#1 chosen from 1 choice<BR>ub(1.2): GetMaxLUN returned 0, using 1 LUNs<BR>Oops: 
kernel access of bad area, sig: 11 [#1]<BR>NIP: 00000000 LR: C0170314 CTR: 
00000000<BR>REGS: c030bd40 TRAP: 0400&nbsp;&nbsp; Not tainted&nbsp; 
(2.6.17-rc3)<BR>MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 42004024&nbsp; XER: 
20000000<BR>TASK = c02c78f8[0] 'swapper' THREAD: c030a000<BR>GPR00: 00000000 
C030BDF0 C02C78F8 C75CE800 C75D0A00 00000000 00000008 00000008 <BR>GPR08: 
00000001 00000000 C75D0A00 C75CE854 22004082 00000000 07FF7F00 00000000 
<BR>GPR16: 00000001 00000001 FFFFFFFF 007FFF00 07FF2B4C 00000000 C75CE9D4 
C016F5C0 <BR>GPR24: 00029030 00000000 C75CE960 C75CE9F4 C75CE978 C0330000 
00000000 C75CE800 <BR>Call Trace:<BR>[C030BDF0] [C0330000]&nbsp; 
(unreliable)<BR>[C030BE10] [C01704C8] <BR>[C030BE40] [C001F734] <BR>[C030BE60] 
[C001F908] <BR>[C030BE90] [C0007CC0] <BR>[C030BEA0] [C001F638] <BR>[C030BEB0] 
[C0007C1C] <BR>[C030BED0] [C00032F8] <BR>[C030BF90] [C000A6B0] <BR>[C030BFB0] 
[C0002358] <BR>[C030BFC0] [C030C694] <BR>[C030BFF0] [C0002254] <BR>Instruction 
dump:<BR>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
<BR>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
<BR>Kernel panic - not syncing: Aiee, killing interrupt 
handler!<BR>&nbsp;&lt;0&gt;Rebooting in 1 seconds.. </DIV>
<DIV>&nbsp;</DIV>
<DIV>rarely,it can boot successfully,shows:</DIV>
<DIV>Initializing USB Mass Storage driver...<BR>usb 1-3: new high speed USB 
device using ehci_hcd and address 2<BR>usb 1-3: Product: USBFlash<BR>usb 1-3: 
Manufacturer: Generic <BR>usb 1-3: configuration #1 chosen from 1 
choice<BR>ub(1.2): Unable to submit GetMaxLUN (-22)&nbsp; <BR>usbcore: 
registered new driver usb-storage<BR>USB Mass Storage support registered.<BR>TCP 
bic registered</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have tried to configure kernel many times...but the problem still 
exists....</DIV>
<DIV>any advise is appreciated.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>tony</DIV></BODY></HTML>

--=====003_Dragon614514446686_=====--
