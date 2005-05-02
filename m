Return-Path: <ole.torvmark@radionor.no>
Received: from mail.radionor.no (217-13-18-54.dd.nextgentel.com [217.13.18.54])
	by ozlabs.org (Postfix) with ESMTP id 2AF8A67B41
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 19:52:26 +1000 (EST)
Received: from [192.168.0.159] (olesibm.radionor.no [192.168.0.159])
	by mail.radionor.no (Postfix) with ESMTP id 7F5F827294
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 11:29:19 +0200 (CEST)
Message-ID: <4275F2BB.9050100@radionor.no>
Date: Mon, 02 May 2005 11:28:27 +0200
From: Ole Andreas Torvmark <ole.torvmark@radionor.no>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Ethernet bridging on MPC8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi !

I've a custom board with a MPC8248 with two LXT972 10/100MBit ethernet phys.

The board is running 2.6.9-rc1, and I'm using the FCC ENET Version 0.3 
driver with some modifications.

My question is :

I've tried to get ethernet briding between the two ethernet ports to work.

I've set up the following :

ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
ifconfig br0 192.168.0.222 netmask 255.255.255.0

If I connect a machine to port 0 (eth0) then I can ping the bridge from 
that machine,
If I connect a machine to port 1 (eth1) I cannot ping the bridge.
If I connect machines to both ports, I cannot ping one machine from the 
other, the only thing i can successfully ping is from port 0 to bridge 
and from bridge to port 0

Is this a known problem with the FCC ENET driver or does it support 
bridging fully ?

best regards

Ole Andreas Torvmark
R & D Engineer
Radionor Communications AS
