Message-Id: <200403310303.i2V3366P010744@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Network problem: Ping is OK, Yet telnet and ftp etc is not working
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 31 Mar 2004 11:2:22 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all

     We use ADMTek AN983B chip as our network chip. And I have porting
linux to this MPC8241 platform.Now I have a very strange problem:
   If I ping my target, no answer. When I start tcpdump on my target,
the ping ... works fine. Since the hardware is put into promiscuous
mode when tcpdump is running, So I use ifconfig to put NIC work in
promiscuous mode. I thought it can temporarily solve the problem. Now
ping is OK. However When I telnet other machine, no answer.And When I
telnet my target, still no answer. I thought it may because of firewall.
So I undef CONFIG_NETFILTER in .config and autoconf.h. Still the same.
So what could be the problem?

Best regards

Jack Liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
