Message-ID: <3B6FA2F7.1C1A2BA2@genetel.co.kr>
Date: Tue, 07 Aug 2001 17:12:39 +0900
From: hychon <hychon@genetel.co.kr>
Reply-To: hychon@genetel.co.kr
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: (enet) - hardware address??
Content-Type: multipart/mixed;
 boundary="------------8FBF574DFD6F5F31190F5701"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MIME 형식의 멀티-파트 메시지입니다.
--------------8FBF574DFD6F5F31190F5701
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit


I want to use to two ethernet device (fec and SCC1) base on MPC860T and
I use kernel-2.2.13.
when I am boot that , it come in to collision between devices.

boot message ================================
eth0: CPM ENET Version 0.2 on SCC1, 00:06:42:00:00:01
eth1: FEC ENET Version 0.1, fec: Phy @ 0x0, type 0x001378e1
00:fec: link up,auto complete
06:fec: 10 Mbps, Half-Duplex
42:00:00:01
IP-Config: Incomplete network configuration information.
dev_close: bug eth0 still running
===============================================================

how to allocate a hardware address (mac address) to each device in
kernel ?
--------------8FBF574DFD6F5F31190F5701
Content-Type: text/x-vcard; charset=EUC-KR;
 name="hychon.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for hychon
Content-Disposition: attachment;
 filename="hychon.vcf"

begin:vcard
n:;
x-mozilla-html:FALSE
adr:;;;;;;
version:2.1
x-mozilla-cpt:;0
end:vcard

--------------8FBF574DFD6F5F31190F5701--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
