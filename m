Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FAE0@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: TX errors on eth0
Date: Thu, 1 Nov 2001 11:02:09 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using Linux kernel 2.4.6 on a custom MPC823 board. I don't seem to be
having any problem with Ethernet functionality. I am running DHCP, httpd,
telnet, and Samba successfully. If I run ifconfig the number of TX packets
is 0 and there is a large number of TX errors. I am assuming that it is a
problem with the way the transmit statistics is getting updated. Has anyone
else seen this problem?
Does anyone know how to fix it?

Following is the output of ifconfig:

[root@acornbd1 /root]# ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Bcast:127.255.255.255  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0 coll:0

eth0      Link encap:Ethernet  HWaddr AA:55:00:06:14:45
          inet addr:142.42.6.44  Bcast:142.42.255.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11169 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:4444 dropped:66 overruns:0 carrier:0 coll:0
          Base address:0x3d00

Thanks,
Cindy Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
