Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A84DB7104
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2011 22:25:22 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1PwYJb-00066k-LP
	for linuxppc-dev@ozlabs.org; Mon, 07 Mar 2011 03:09:27 -0800
Message-ID: <31086738.post@talk.nabble.com>
Date: Mon, 7 Mar 2011 03:09:27 -0800 (PST)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: Mpc8315erdb openvpn segmentation fault
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


i'm facing a problem. i've installed openvpn on mpc8315erdb board and when i
give the command

openvpn --mktun --dev tap0 i get the error

 

[root@mpc8315erdb /]# openvpn --mktun --dev tap0
Sat Jan  1 01:04:21 2000 OpenVPNUnable to handle kernel paging request for
data
at address 0x00000000
 2.0.9 ppc-rpm-lFaulting instruction address: 0xc90a208c
inux-gnu [SSL] [Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in: tun
**bleep**: c90a208c LR: c90a2068 CTR: c0288e58
REGS: c294fd80 TRAP: 0300   Not tainted  (2.6.29.6)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24002424  XER: 20000000
DAR: 00000000, DSISR: 20000000
TASK = c70b6440[1635] 'openvpn' THREAD: c294e000
GPR00: 00000001 c294fe30 c70b6440 c03ebcf4 bfafa0d4 0000001c c294fe58
0fd8dc58
GPR08: 00000000 00000001 ffffffe7 00000000 84002428 100787e0 07ff9000
00000004
GPR16: 00000000 00000000 bfafa930 00010000 00010000 ffffffff 00000005
3b9aca00
GPR24: c7023d20 c294fe3c bfafa0b8 c653e6e0 00000000 c040baf4 bfafa0b8
800454ca
Call Trace:
[c294fe30] [c90a2068] 0xc90a2068 (unreliable)
[c294fe90] [c008054c] 0xc008054c
[c294fea0] [c00809c4] 0xc00809c4
[c294ff10] [c0080c9c] 0xc0080c9c
[c294ff40] [c001141c] 0xc001141c
--- Exception: c01 at 0xfce8268
    LR = 0xfd6bdec
Instruction dump:
4bfffecc 9b81001b 480008ed 3d20c90a 38000001 8129306c 81620308 2f890000
830201a4 83ab0014 817d0124 419e0014 <800b0000> 7c090010 7c000110 7c0000d0
LZO] [EPOLL] bui---[ end trace 54eee2a93ccf53d1 ]---
lt on Mar  2 2011
Sat Jan  1 01:04:21 2000 IMPORTANT: OpenVPN's default port number is now
1194, b
ased on an official port number assignment by IANA.  OpenVPN 2.0-beta16 and
earl
ier used 5000 as the default port.
Sat Jan  1 01:04:21 2000 ******* WARNING *******: all encryption and
authenticat
ion features disabled -- all data will be tunnelled as cleartext
Segmentation fault

 

Some one plz help me out! wat does this mean? Coz with the same kernel image
and the same settings  i'm able to successfully run the above command on
another mpc8315erdb board. but it fails on one of the board! any ideas would
be of great help to me!! plz!
-- 
View this message in context: http://old.nabble.com/Mpc8315erdb-openvpn-segmentation-fault-tp31086738p31086738.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
