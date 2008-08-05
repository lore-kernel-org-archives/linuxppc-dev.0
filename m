Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8833BDE1B6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:49:19 +1000 (EST)
Message-ID: <4898BCD3.5050703@freescale.com>
Date: Tue, 05 Aug 2008 15:49:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use
	immr alias if it exists.
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<200808052243.24001.arnd@arndb.de>
In-Reply-To: <200808052243.24001.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 05 August 2008, John Rigby wrote:
>> This will allow the eventual removal of device_type = "soc"
>> properties in soc nodes.
> 
> Stupid question, but why not remove immrbase instead?
> 
> It seems that all users can be converted to use a reg
> property of some actual device instead of making assumptions
> about the register layout of the whole SOC.

That wouldn't eliminate the need for the alias, though -- u-boot needs 
to find the node to fill in properties.

-Scott
