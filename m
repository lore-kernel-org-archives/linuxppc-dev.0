Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3B571A6A.AFAE4844@comdev.cc>
Date: Thu, 19 Jul 2001 10:35:38 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: fcc_enet Phy detection
References: <3B5708DD.E0788B8B@comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is this normal?


eth0      Link encap:Ethernet  HWaddr 08:00:22:70:70:63
          inet addr:192.168.67.56  Bcast:192.168.67.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9586 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6231 errors:43 dropped:0 overruns:43 carrier:6188
          collisions:7 txqueuelen:100
          RX bytes:4919915 (4.6 Mb)  TX bytes:741495 (724.1 kb)
          Base address:0x8600

I'm getting a "carrier lost" for every sent packet.
When I telnet in, the telnet session hangs, usually after a few
commands,
and the "overruns" (typo? should be underruns?) and "errors" increment
by either 2 (typical) or 1 (sometimes).

Any help is appreciated.

--Adam
--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
