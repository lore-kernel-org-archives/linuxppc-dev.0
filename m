Return-Path: <schardt@team-ctech.de>
Received: from www2.team-ctech.de (www2.team-ctech.de [62.146.20.117])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76836DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 17:30:20 +1000 (EST)
Message-ID: <48C62603.7080606@team-ctech.de>
Date: Tue, 09 Sep 2008 09:30:11 +0200
From: Georg Schardt <schardt@team-ctech.de>
MIME-Version: 1.0
To: Neeraj Garg <neerajg@cdac.in>
Subject: Re: EDK10.1 and emaclite
References: <48C5F6ED.4000804@cdac.in>
In-Reply-To: <48C5F6ED.4000804@cdac.in>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

mmh, there is no kernel message with PHY detection, but all PHY drivers 
are compiled in.
i looked at my xps project and there is only one ip-core "Ethernet_MAC" 
with type "xps_ethernetlite".
is it possible that the phy connection is missing ? i use the base 
system builder with the board support files supported from avnet.

where can i look for the ethernet speed ? the ethernetlite ip has no 
speed options

thanks for your help
georg

Neeraj Garg wrote:
> Hi Georg,
>
> Can you post linux bootup message where its says PHY is detected at 
> paticular address, and check with your hardware what is actual address 
> of PHY. Also I would like to know the configuration of your hardware 
> whether its configured of 10MBPS OR 100MBPS.
>
>
> ------------------------------------------------------------------------------------------ 
>
> -- 
> Neeraj Garg
>
>
>
> Message: 3
> Date: Mon, 08 Sep 2008 18:29:53 +0200
> From: Georg Schardt <schardt@team-ctech.de>
> Subject: EDK10.1 and emaclite
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <48C55301.4070208@team-ctech.de>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hi all,
>
> im trying to use the emaclite core which comes with the EDK10.1 with 
> the 2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the 
> emac is detect by the kernel:
>
> xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0: 0: 0: 0: 0
> xilinx_emaclite xilinx_emaclite.0: using fifo mode.
> xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000 
> mapped to 0xC5060000, irq=0
>
> i can change the mac-address with ifconfig and i can give an 
> ip-address to the device,
> but a ping is not possible and arp is not working. i think that the 
> phy is not working right.
>
> has someone others the same problem ? what can i changed ? i have 
> tried out all possible phy driver in the linux  kernel
>
> a setup with the lltemac is working fine, but i want to use the emaclite
>
> thanks
> regards
> georg
>
