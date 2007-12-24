Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C982DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 04:40:22 +1100 (EST)
Message-ID: <476FEEE5.7030609@freescale.com>
Date: Mon, 24 Dec 2007 11:39:49 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD5DF.5020806@freescale.com>
	<20071224121715.GB7903@localhost.localdomain>
In-Reply-To: <20071224121715.GB7903@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>> You need "bus-frequency" here too
> 
> Hm.. 
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
> 
> ^^ David Gibson suggested to get rid of it.

It looks to me like he's just suggesting that we rename it to 
clock-frequency.  That may be a better name, but for now changing it 
will only confuse U-Boot and any other code that's looking for 
bus-frequency.  If we want to rename it, I suggest we do that in a 
different patch.  Having some DTS files with "bus-frequency" and others 
with "clock-frequency" is bad.
