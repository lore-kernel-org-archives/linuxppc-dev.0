Message-ID: <017101c0189c$de480300$2a6cabd3@dolbae>
From: "SangTae Ha" <stha@netstech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC cross compiled dhcpd doesn't work.
Date: Thu, 7 Sep 2000 16:25:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all.

I'm making root file system. My problem is ...
If I compile the dhcp server in x86 environment, It works well. But in ppc environment, it doesn't.
No compile error comes out.. But it doesn't work.
In bugging messages, "ip length 328 disagrees with bytes received 332". Is it an endian problem?
I aready sniffed packets, but I can't find a clue. I am using libc.so.6 which obtained montavista hardhat linux CDK.

Does any one succeeded in compiling and running dhcpd ?
My dhcpd is from http://www.isc.org/products/DHCP/ and ftp site ftp://ftp.isc.org/isc/dhcp/dhcp-2.0pl4.tar.gz

Thanks in advance.

Debugging message ....
-----------------------------------------------------------------------------
# /sbin/dhcpd-v2 -d -f eth1
Internet Software Consortium DHCP Server 2.0pl4
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth1/00:10:ec:00:14:42/192.168.10.0
Sending on   LPF/eth1/00:10:ec:00:14:42/192.168.10.0
Sending on   Socket/fallback/fallback-net
ip length 328 disagrees with bytes received 332.
accepting packet with data after udp payload.
DHCPDISCOVER from 00:00:0e:d2:98:e5 via eth1
no free leases on subnet 192.168.10.0
ip length 328 disagrees with bytes received 332.
accepting packet with data after udp payload.
DHCPDISCOVER from 00:00:0e:d2:98:e5 via eth1
no free leases on subnet 192.168.10.0
ip length 328 disagrees with bytes received 332.
accepting packet with data after udp payload.
DHCPDISCOVER from 00:00:0e:d2:98:e5 via eth1
no free leases on subnet 192.168.10.0
-------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
