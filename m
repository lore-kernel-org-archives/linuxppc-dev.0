Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 43209DDEE0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:32:26 +1000 (EST)
Message-ID: <466735F3.7040504@freescale.com>
Date: Wed, 06 Jun 2007 17:32:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com> <20070606222456.GA28225@lixom.net>
In-Reply-To: <20070606222456.GA28225@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

>  - you can never assign a __le16 type to any other integer type or any 
>    other bitwise type. You'd get a warnign about incompatible types. Makes 
>    sense, no?

Then why do the in_be functions return an unsigned int instead of a __be type?  Isn't that 
effectively removing the endian-ness from the type?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
