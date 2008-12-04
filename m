Return-Path: <timur.tabi@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id 57B73DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:15:35 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id y26so1193175ele.19
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Dec 2008 09:15:32 -0800 (PST)
Message-ID: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
Date: Thu, 4 Dec 2008 11:15:32 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com
Subject: "eth1: Could not attach to PHY" on MPC8349e-MITX
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale MPC8349e-MITX reference board has two TSECs, the second
of which (eth1) is attached to a Vitesse 7385 5-port switch.

Using the latest U-Boot, Kernel, and device tree, I cannot bring up
eth1.  When I try, I get this message:

[root@tintin root]# ifconfig eth1 up
0:01 not found
eth1: Could not attach to PHY
SIOCSIFFLAGS: No such device

Unfortunately, I don't even know what this means.

I believe my network configuration is correct.  Here's what ifconfig
says about eth1:

eth1      Link encap:Ethernet  HWaddr 00:E0:0C:00:8C:02
          inet addr:192.168.2.141  Bcast:192.168.255.255  Mask:255.255.0.0
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0x4000

eth1 does work in U-boot, so I know it can be made to work (and I know
the 7385's firmware is uploaded), I just don't know what needs to be
done in Linux.
-- 
Timur Tabi
Linux kernel developer at Freescale
