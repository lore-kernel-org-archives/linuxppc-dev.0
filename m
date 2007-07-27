Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DC89DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 16:47:04 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IEJbA-0004J1-Gq
	for linuxppc-embedded@ozlabs.org; Thu, 26 Jul 2007 23:46:52 -0700
Message-ID: <11823845.post@talk.nabble.com>
Date: Thu, 26 Jul 2007 23:46:52 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ping command
In-Reply-To: <1185458965.6839.8.camel@saruman.qstreams.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11779249.post@talk.nabble.com>
	<1185458965.6839.8.camel@saruman.qstreams.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


root@cashel:~# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.178.0   0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.32.0    0.0.0.0         255.255.248.0   U     0      0        0 eth1
0.0.0.0         192.168.32.47   0.0.0.0         UG    0      0        0 eth1
0.0.0.0         192.168.178.47  0.0.0.0         UG    0      0        0 eth0
root@cashel:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:13:72:FE:A9:02
          inet addr:192.168.178.89  Bcast:192.168.178.255 
Mask:255.255.255.0
          inet6 addr: fe80::213:72ff:fefe:a902/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:15665 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9285 errors:0 dropped:0 overruns:0 carrier:9019
          collisions:0 txqueuelen:1000
          RX bytes:12957285 (12.3 MiB)  TX bytes:2720267 (2.5 MiB)
          Base address:0x8400

eth1      Link encap:Ethernet  HWaddr 00:13:72:7E:A9:02
          inet addr:192.168.33.135  Bcast:192.168.33.255  Mask:255.255.248.0
          inet6 addr: fe80::213:72ff:fe7e:a902/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:634 errors:0 dropped:0 overruns:0 frame:0
          TX packets:84 errors:0 dropped:0 overruns:0 carrier:82
          collisions:0 txqueuelen:1000
          RX bytes:103558 (101.1 KiB)  TX bytes:12832 (12.5 KiB)
          Base address:0x8500

lo        Link encap:Local Loopback
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

root@cashel:~#


On Wed, 2007-07-25 at 02:29 -0700, Nethra wrote:
> hi,
> 
> I m using custom board same as eval board MPC8272ADS board.
> 
> IP assigned for both ethernets are...
> 
>               ifconfig eth1 192.168.33.135 up
> 	 ifconfig eth1 netmask 255.255.248.0
>  	 route add default gw 192.168.32.47 eth1
>  
> 
> 	 ifconfig eth0 192.168.178.89 up
> 	 ifconfig eth0netmask 255.255.255.0
> 	 route add default gw 192.168.178.47 eth0
> 
> but if i try for ping 192.168.33.135 command pails by the server of 178
> series
> similarly ping 192.168.178.89 command pails by the server of 33 series..
> 
> what is the problem..and whre i m going wrong..?

What does your routing table show?  (route -n).  It wouldn't hurt to
also post the output of ifconfig for both interfaces.

regards,
Ben

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



-- 
View this message in context: http://www.nabble.com/ping-command-tf4141032.html#a11823845
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
