From: "Ole Andreas Torvmark" <ole.torvmark@radionor.no>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with Sandpoint 8240 & i82559 & i82550
Date: Wed, 22 Aug 2001 12:56:54 +0200
Message-ID: <MHEAIGEFFBAFIOMKCIGCMEAICAAA.ole.torvmark@radionor.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


During boot the board comes to this point :



IDE timing: 000003e4, resetting to PIO0 timing
hda: IBM-DTLA-307030, ATA DISK drive
ide0 at 0xbffff8-0xbfffff,0xbffff6 on irq 14
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
Partition check:
 hda: [PTBL] [3737/255/63] hda1 hda2 < hda5 >
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ena
bled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drive
rs/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@sa
w.sw.com.sg> and others
eth0: PCI device 8086:1229, 00:02:B3:60:8F:9F, IRQ 16.
  Board assembly 751767-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
Self test failed, status ffffffff:
 Failure to initialize the i82557.
 Verify that the card is a bus-master capable slot.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Sending BOOTP requests....<4>eth0: card reports no RX buffers.
.<1>eepro100: wait_for_cmd_done timeout!
.<1>eepro100: wait_for_cmd_done timeout!

First off the problem seems to be that the self test fails.  And then i get
the wait_for_cm_done timeout! message. I have tried two different intel
cards the one is i82550 based and the other is older and based on the i82559
chip. We have a Linux server here running 2.4.8 and it has the exactly same
driver and it does not fail so I think it is something with the Sandpoint
Reference Platform.

regards

Ole A. Torvmark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
