Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B2DFDDDD4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Nov 2008 03:43:52 +1100 (EST)
Message-ID: <491C58F7.5020108@freescale.com>
Date: Thu, 13 Nov 2008 10:42:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: saadia dhouib <saadia_dhouib@yahoo.fr>
Subject: Re: ifconfig: SIOCSIFNETMASK: No such device (xupv2p+ppc+linux
	2.6.27-rc)
References: <20481642.post@talk.nabble.com>
In-Reply-To: <20481642.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

saadia dhouib wrote:
> Device Tree Probing 'ethernet'
> xilinx_emac 40c00000.ethernet: no IRQ found.

This might be a problem.

> root:~> ifconfig 172.25.49.123 netmask 255.255.255.0
> ifconfig: SIOCSIFNETMASK: No such device
> root:~> ### Application running ...
> 
> 
> 
> My question is: why I can't assign an IP address ??

ifconfig eth0 172...

-Scott
