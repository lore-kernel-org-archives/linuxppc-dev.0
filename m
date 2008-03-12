Return-Path: <Ingo.Donasch@l-3com.com>
Received: from firewallb.vividusa.com (vividusa.com [207.180.153.5])
	by ozlabs.org (Postfix) with ESMTP id B6AD9DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 23:18:53 +1100 (EST)
Received: from merlin.sds.l-3com.com (merlin.sds.l-3com.com [172.20.0.31])
	by firewallb.vividusa.com (8.13.3/8.13.3) with ESMTP id m2CBxO7g030785
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 07:59:24 -0400
Received: from boreas.corp.sds.l-3com.com (boreas [172.20.0.123])
	by merlin.sds.l-3com.com (8.13.7/8.13.7) with ESMTP id m2CBxKeb006611
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 07:59:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: slow Kilauea TCP throughput?
Date: Wed, 12 Mar 2008 07:59:15 -0400
Message-ID: <9E33F44949583B4597BDA2D06042567003734A0F@FLS-EXCHANGE.corp.sds.l-3com.com>
From: "Donasch, Ingo @ SDS" <Ingo.Donasch@l-3com.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a project where I would like to use the AMC405EX under Linux for
high speed data acquisition. I have the Kilauea board in the lab but
measured only 150Mbit/s TCP throughput (outbound) with iperf. I need
twice of that and actually expecting 3x higher bandwidth from that
architecture.
what is it that I'm missing?
can anybody confirm my results or tell me what am I doing wrong?
any help is appreciated
sincerely
ingo

/home # uname -a
Linux kilauea 2.6.23-g1dfaad37 #1 Wed Nov 21 07:15:18 CET 2007 ppc
unknown

home # ./iperf -c 192.168.1.249 -t60 -i1
------------------------------------------------------------
Client connecting to 192.168.1.249, TCP port 5001 TCP window size: 16.0
KByte (default)
------------------------------------------------------------
[  5] local 192.168.1.50 port 59035 connected with 192.168.1.249 port
5001
[  5]  0.0- 1.0 sec  16.6 MBytes    139 Mbits/sec
[  5]  1.0- 2.0 sec  16.6 MBytes    140 Mbits/sec
...
[  5] 58.0-59.0 sec  18.0 MBytes    151 Mbits/sec
[  5] 59.0-60.0 sec  18.0 MBytes    151 Mbits/sec
[  5]  0.0-60.0 sec  1.04 GBytes    148 Mbits/sec
/home # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:06:4B:10:19:5B =20
          inet addr:192.168.1.50  Bcast:192.168.1.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:798928 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1634765 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:53947650 (51.4 MiB)  TX bytes:2341215308 (2.1 GiB)

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


*********************************************************************
The information contained in this e-mail is intended only for the person
or entity to which it is addressed and may contain confidential and / or
privileged material. If you are not the intended recipient of this
e-mail, the use of this information or any disclosure, copying or
distribution is prohibited and may be unlawful.=20

If you received this in error, please contact the sender and delete the
material from any computer.=20

L-3 Communications Security Systems, manufacturer of the eXaminer 3DX
6000 Explosive Detection System - <http://www.l-3com.com>
**********************************************************************
