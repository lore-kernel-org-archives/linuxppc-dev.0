Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D6A6D9D.20404@redswitch.com>
Date: Mon, 26 Aug 2002 11:04:13 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Wolfgang Denk <wd@denx.de>
Subject: Re: LXT972 FEC problem on MPC855
References: <3D69826A.6020504@redswitch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> After running ppcboot on our board successfully (including the fast
> ethernet LXT972), we have trouble on enabling FEC on linux kernel. The
> problem is that we cannot send any packets through the network after the
> kernel is booted. The ethernet looks OK during initialization according
> to the printed messages. We are trying to locate the problem but haven't
> found yet so far. Any hints on what caused such problem?

The booting messages are as follows,
-------------duing initialization-----------------------------
eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 10, addr 00:06:17:01:02:00
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
-------------duing initialization-----------------------------
-------------Stack init (I guess)-----------------------------
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
-------------Stack init (I guess)-----------------------------

Using FLUKE to test the ethernet interface, it looks OK. No problem is
reported. But we couldn't see any packets transmitted out by the
interface. Have you encountered such problem before? Any hints will be
greatly appreciated. Thanks a lot.

> My configuration on kernel (linux-2.4.4-08-09 from DENX) is
>              860T FEC Ethernet
>              Use MDIO for PHY configuration
>              Support LXT971 PHY

BTW, if I disable "Use MDIO for PHY configuration", after I ping an
address, it'll dump data in TX ring buffer. If those data will help to
diagnose the problem, I'll paste them later.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
