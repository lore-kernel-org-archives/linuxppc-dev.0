Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id CCA372BDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2004 13:40:18 +1000 (EST)
Message-ID: <4158DD68.2060707@sonartech.com.au>
Date: Tue, 28 Sep 2004 13:41:28 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
In-Reply-To: <AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's not the platform; I've run both e1000 and tg3 successfully
> on PowerPC systems, no problems getting it to work at all.
>
What kernel are you using? it's just that the irq's I'm getting for the 
gigabit devices are zero (dual gigabit ethernet card) for the 2.6.9-rc2 
plus patchs kernel but for the 2.4 series I was getting 12 and 9 as can 
be seen below and configuring the devices worked fine. I've also noticed 
that there have been recent changes made to the irq routing in the 
kernel so this may have something to do with it so I'll try one the 
i386's with gigabit with the 2.6.9-rc2 and see what I get!

dmesg from 2.6 series:
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension 
(NICE) ver. 7.3.5 (06/23/04)
eth2: Broadcom BCM5704 1000Base-SX found at mem f2ef0000, IRQ 0, node 
addr 0030f76e4eee
eth2: Broadcom BCM5704 Integrated SerDes transceiver found
eth2: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON, TSO ON
eth3: Broadcom BCM5704 1000Base-SX found at mem f2ed0000, IRQ 0, node 
addr 0030f76e4eef
eth3: Broadcom BCM5704 Integrated SerDes transceiver found
eth3: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON, TSO ON

dmesg from 2.4 series:
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension 
(NICE) ver. 7.1.22 (01/07/04)
eth2: Broadcom BCM5704 1000Base-T found at mem f2ef0000, IRQ 12, node 
addr 0030f74d479c
eth2: Broadcom BCM5704 Integrated Copper transceiver found
eth2: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON, NAPI ON
eth3: Broadcom BCM5704 1000Base-T found at mem f2ee0000, IRQ 9, node 
addr 0030f74d479d
eth3: Broadcom BCM5704 Integrated Copper transceiver found
eth3: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 
802.1Q VLAN ON, NAPI ON
