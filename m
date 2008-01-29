Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 620E0DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 06:26:10 +1100 (EST)
Message-ID: <479F7DC8.5010402@freescale.com>
Date: Tue, 29 Jan 2008 13:26:00 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] 82xx: MGCOGE support
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>	<479EFE71.5090201@denx.de>
	<20080129192033.GB4051@loki.buserror.net>
In-Reply-To: <20080129192033.GB4051@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> +		// Temporary -- will go away once kernel uses ranges for get_immrbase().
>> +		reg = <0xf0000000 0x00053000>;
> 
> The patch to use ranges for get_immrbase() just went in, so we can drop this
> now.

Most excellent.

Time for YARDS -- Yet Another Rounds of DTS Scrubbing.

jdl
