Return-Path: <divanov@nateurope.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C8E5CB6FE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 00:13:12 +1000 (EST)
Message-ID: <4F7B056F.8010100@nateurope.com>
Date: Tue, 3 Apr 2012 16:13:03 +0200
From: dimitar <divanov@nateurope.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: P4080 Device tree
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I hope I'm posting my question on the right place.
Please be gentle to me, since I'm newbie in Linux Kernel.

I'm porting Linux to a custom board based on P4080DS BSP. My problem is 
that I cannot understand the configuration of th DPA in the device tree 
including QMAN, BMAN and FMAN.

During my work i was faced firstly to a issue, that the "phy-handle" in 
the Ethernet node of the FM0 could not be parsed correctly using the 
function "of_parse_phandle()".
After replacing the "of_parse_phandle()" by "of_find_node_by_path" inc 
mac.c of the DPA package, the Phy was correctly bind to the Ethernet node.

The second preblem I'm now facing to, is that during "ping" the CPUs 
hang after an exchange of few packets over the network.

How exactly should be the BMAN, QMAN and FMAN configured in the device 
tree?
I mean I'm using the similar device tree as the FSL P4080DS. The only 
difference that the board uses MDIO bus, on which a PHY is connected.

Is there any documentation for the device tree?

In addition I have tested the network interfaces with another OS system 
that is using the same NetCom library. Therefore the problem is not the 
hardware.

Please help!

Regards
Dimitar
