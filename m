Return-Path: <jostein.pettersen@westerngeco.com>
Received: from mail.slb.com (eurmta02.montrouge.eur.slb.com [163.187.152.23])
	by ozlabs.org (Postfix) with ESMTP id 83ABF2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Dec 2004 03:00:32 +1100 (EST)
Received: from pmxchannel-daemon.eurmta02.montrouge.eur.slb.com by
	eurmta02.montrouge.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0I8G00F0DP1YE0@eurmta02.montrouge.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Thu, 09 Dec 2004 15:44:22 +0000 (GMT)
Received: from wgmail3.oslo.eur.slb.com
	(wgmail3.oslo.eur.slb.com [134.32.44.153]) by
	eurmta02.montrouge.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0I8G001UWP1VM8@eurmta02.montrouge.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Thu, 09 Dec 2004 15:44:20 +0000 (GMT)
Received: from OSL-1205-PC.westerngeco.com (localhost [127.0.0.1])
	by wgmail3.oslo.eur.slb.com (Switch-2.2.8/8.11.1) with ESMTP id
	iB9FhXE22528 for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Dec 2004 16:43:33 +0100 (MET)
Date: Thu, 09 Dec 2004 16:43:41 +0100
From: Jostein Pettersen <jostein.pettersen@westerngeco.com>
To: linuxppc-embedded@ozlabs.org
Message-id: <5.1.0.14.2.20041209153709.02cfa5f8@wgmail3.oslo.eur.slb.com>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_9A1n6qV6SFgqMd/OFU4qiA)"
Subject: Software routing in 8275
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary_(ID_9A1n6qV6SFgqMd/OFU4qiA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Hi,

We consider using a MPC8275 running Embedded Linux to route two 100MB/s 
Ethernet links in software. The traffic will mostly be incoming on the two 
FE links and outgoing on the PCI bus, which is connected to a gigabit 
routing chip (can't connect the two FE links to the routing chip directly, 
since it only has GE ports).

My question is:
Will the MPC8275 be able to handle 2xFE full speed?

Doing the calculations about bus speeds etc, it looks ok, but I know Linux 
does not like high interrupt rates. Is there a rule of thumb about what's 
the maximum recommended interrupt rate at a given clock speed?

Hope to hear from you,
Regards
Jostein Pettersen


--Boundary_(ID_9A1n6qV6SFgqMd/OFU4qiA)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<html>
Hi,<br><br>
We consider using a MPC8275 running Embedded Linux to route two 100MB/s
Ethernet links in software. The traffic will mostly be incoming on the
two FE links and outgoing on the PCI bus, which is connected to a gigabit
routing chip (can't connect the two FE links to the routing chip
directly, since it only has GE ports).<br><br>
My question is:<br>
<b>Will the MPC8275 be able to handle 2xFE full speed?</b> <br><br>
Doing the calculations about bus speeds etc, it looks ok, but I know
Linux does not like high interrupt rates. Is there a rule of thumb about
what's the maximum recommended interrupt rate at a given clock speed?
<br><br>
Hope to hear from you,<br>
Regards<br>
Jostein Pettersen<br><br>
</html>

--Boundary_(ID_9A1n6qV6SFgqMd/OFU4qiA)--
