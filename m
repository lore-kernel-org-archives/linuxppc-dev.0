Return-Path: <vijesh.vh@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.202])
	by ozlabs.org (Postfix) with ESMTP id EBC1867A83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 19:21:04 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so1103761rnf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 00:21:02 -0800 (PST)
Message-ID: <8e78982e0503220021a849bf2@mail.gmail.com>
Date: Tue, 22 Mar 2005 13:51:02 +0530
From: Vijesh VH <vijesh.vh@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Help Regarding DEVFS
Reply-To: Vijesh VH <vijesh.vh@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
 I faced a problem when i was doing Netboot on linux 2.4.29 on IBM
PowerPC 4xx Processor. I am using filesystem develped for 2.4.18. Can
anyone help me to sort out the problem.
*************************************************************************************
IP-Config: Got BOOTP answer from 192.168.48.143, my address is 192.168.48.3
eth0:smc_set_multicast_list
LAN91C111:smc_setmulticast
IP-Config: Complete:
      device=eth0, addr=192.168.48.3, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.48.3, domain=mylinux.org, nis-domain=macindia.org,
     bootserver=192.168.48.143, rootserver=192.168.48.143, rootpath=/stb
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.48.143
Looking up port of RPC 100005/1 on 192.168.48.143
nfs: server 192.168.48.143 not responding, still trying
nfs: server 192.168.48.143 OK
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 80k init
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..
***********************************************************************************

-- 
Thanks and Regards,
Vijesh V H
