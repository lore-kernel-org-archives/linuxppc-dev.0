From: g.ramakrishna@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578616C92E@AP-BANG-M02>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Can not boot linux-2.4.4 using ppcboot-1.0.4
Date: Fri, 21 Sep 2001 01:30:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am trying to boot Linux-2.4.4 kernel using ppcboot-1.0.4.
It hangs after printing "## Transferring control to Linux (at address
00000000) ..."
I have given below the sequence of steps followed during the booting time.
Could someone please help me in this regard.
Any kind of help would be greately appreciated.

Thanking you in advance.

Regards,
Ramakrishna, G


                \\'''//
                -(o o)-
+---------oOOO----(_)--------------------+
|  Ramakrishna, G                        |
|  Tektronix - TEDI                      |
|  e-mail : g.ramakrishna@tek.com        |
|           grk_bits@yahoo.com           |
|  Tel    : +91-80-2215535 Ext:3414      |
|  Fax    : +91-80-2215552               |
+------------------------oOOO------------+
                |__|__|
                 || ||
                ooO Ooo


=> bootp 900000
BOOTP broadcast 1
BOOTP broadcast 2
got BOOTP packet (src=67, dst=68, len=321 want_len=300)
Filtering pkt = 0
Bootfile: /nfsroot/linux_image
Got good BOOTP
ARP broadcast 1
Got good ARP - start TFTP
TFTP from server 192.158.104.157; our IP address is 192.158.104.155
Filename '/nfsroot/linux_image'.
Load address: 0x900000
Loading:
############################################################################
########################
done
Bytes transferred = 510250 (7c92a hex)
=> bootm 900000
## Booting image at 00900000 ...
   Image Name:   2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    510186 Bytes = 498 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F9EBF8 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF47
No initrd
## Transferring control to Linux (at address 00000000) ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
