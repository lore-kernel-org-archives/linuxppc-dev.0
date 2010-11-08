Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2D6B1B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Nov 2010 00:25:50 +1100 (EST)
Message-ID: <4CD7FA5A.6020709@gersys.de>
Date: Mon, 08 Nov 2010 14:25:46 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Problem Ethernet Initialization MPC5200 +  LXT971A
References: <4CD431B4.7060405@gersys.de> <4CD7C802.8020908@windriver.com>
In-Reply-To: <4CD7C802.8020908@windriver.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tiejun

tiejun.chen wrote:
> Stefan Strobl wrote:
>> To workaround I could make u-boot run eth_init() always but that doesn't
>> seem the right approach to this.
> 
> Yes. Often we shouldn't depend the bootloader do this when we use NIC. But its
> worth tracking eth_init in detail to check what are missed for Linux. I guest
> those should be dedicated to the hardware. For example, configuring
> multiplex-pin, or reset PHY before the real operation action and so on.
> 

You're right! It was a wrong Port Multiplex Configuration.

I think it's fair to expect the bootloader to do that bit of setup,
since it's very hardware dependent. All I did was to adapt my
CONFIG_SYS_GPS_PORT_CONFIG in u-boot.

Many thanks
Stefan.
