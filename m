Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C90DE67A45
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 04:55:13 +1100 (EST)
In-Reply-To: <F795765B112E7344AF36AA9112796415019ECDC0@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA9112796415019ECDC0@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6F8430E8-0F6E-4440-B158-F8CA12B982F9@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: VLAN support on TSEC
Date: Mon, 6 Mar 2006 11:55:03 -0600
To: Bizhan Gholikhamseh ((bgholikh)) <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

VLAN is supported by gianfar on 8541 the same way it is supported in  
other ethernet devices without hardware VLAN support.  The only  
support it has is that it doesn't drop the frames.  All the detection  
is done by the software.  You may need to change the MTU (by +4) to  
make sure that full-size frames don't get dropped.  I have tested  
VLAN on 8540, and it worked just fine.

On Mar 3, 2006, at 13:27, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi All,
> We are using custom board 8541 based processor, running Linux  
> version 2.6.11.
> In our board, the TSEC interface is connected to a BCM switch chip.  
> We need to configure the interface to support VLAN . The TSEC  
> hardware has no VLAN support and the current driver, gianfar.c, has  
> no support for VLAN either. Are there any implementation of  
> gianfar.c  which supports VLAN?
>
> Many thanks in advance,
> Bizhan
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
