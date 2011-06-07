Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B804B6FAA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jun 2011 23:02:41 +1000 (EST)
Received: by fxm1 with SMTP id 1so3794116fxm.15
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Jun 2011 06:02:37 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jun 2011 18:32:37 +0530
Message-ID: <BANLkTi=TVsXiWR1qS5upnM31kVk9qqXTmw@mail.gmail.com>
Subject: [gianfar]bandwidth management problem on mpc8313 based board
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear All,

I have mpc8313 powerpc based board with silicon revision 2.1. the
processor has two ETH ports (eTsec1 and eTsec2) i.e. eth0 and eth1.
eth0 is 1Gbps port and eth1 is 100Mbps port. On board there is L2
switch from TANTOS2G (psb6972) supports one port 1Gbps,
and from switch there are 4 more eth ports derived which are 100Mbps
ports and port based VLAN is configured for this purpose.

The interface between switch and eth0 (port of processor) is RGMII. So
the processor port and switch port are connected on 1Gbps Link.
The other 4 derived ports (100Mbps) are used to connect to external world.
On this board Embedded Linux is running of kernel version 2.6.23 with HRT patch.
The ethernet controller driver in use is "gianfar" version 1.3
The driver is configured properly as it determines both links 1000Mbps
(eth0) and 100Mbps (eth1) also verified with ethtool.

After this I started to perform bandwidth test using iperf tool.
When I performed this test on one port out of 4 derived ports I am
getting bandwidth in the range of 80-85Mbps
but when the same test is performed on 2 ports simultaneously then the
per port bandwidth is reduced to 40-45Mbps.

But my understanding is all of the 4 ports should support 100Mbps
bandwidth simultaneously (as base port is 1Gbps).
Then why bandwidth gets reduced when more than one port are
communicating simultaneously?
Any reason or suggestion I should check for this problem?

Kindly Please acknowledge, thanks

Kind Regards,
Vijay Nikam
