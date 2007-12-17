Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94C0ADDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 02:19:52 +1100 (EST)
Message-ID: <47669335.4050405@freescale.com>
Date: Mon, 17 Dec 2007 09:18:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/3] mpc82xx: Embedded Planet EP8248E support
References: <20071212225429.GB19027@loki.buserror.net>
	<20071217035912.GB3262@localhost.localdomain>
In-Reply-To: <20071217035912.GB3262@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> As I think I said about another tree, this mdio-under-bcsr arrangement
> is pretty strange.  What's going on here.

As I answered then, it's just the way the hardware is.  I didn't design 
it. :-P

>> +	soc@f0000000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		device_type = "soc";
> 
> Ditch the device_type.

No, it's used by the bootwrapper.  I'll get rid of it if you want to 
write a find_node_by_compatible() function. :-)

-Scott
