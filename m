Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D6A7ECB.3050809@redswitch.com>
Date: Mon, 26 Aug 2002 12:17:31 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LXT972 FEC problem on MPC855
References: <20020826182707.BA14B11829@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
>>IP-Config: Incomplete network configuration information.
>
> You are passing bad/insufficient boot arguments to the Linux  kernel;
> unfortunaltely you don;t show us this part of the boot messages, so I
> cannot even guess what you're doing wrong.
Well, if IP-Config is not complete, we can change the configuration
using 'ifconfig' after the kernel starts. I did that. And I noticed that
'eth0' can receive packets but cannot transmit any packets. Here is the
result of running ifconfig.

---------------------------once----------------------------------
#ifconfig
eth0      Link encap:Ethernet  HWaddr 00:06:17:01:02:00
           inet addr:192.168.5.24  Bcast:192.168.5.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:180 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:18110 (17.6 kb)  TX bytes:0 (0.0 b)
           Base address:0xe00
---------------------------once----------------------------------
---------------------------twice---------------------------------
#ifconfig
eth0      Link encap:Ethernet  HWaddr 00:06:17:01:02:00
           inet addr:192.168.5.24  Bcast:192.168.5.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:282 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:26831 (26.2 kb)  TX bytes:0 (0.0 b)
           Base address:0xe00
---------------------------twice---------------------------------

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
