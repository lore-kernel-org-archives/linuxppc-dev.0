Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 492CFDDFC1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:48:01 +1000 (EST)
Message-ID: <470267E5.4070109@freescale.com>
Date: Tue, 02 Oct 2007 10:46:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: [PATCH] cpm: rounding of brg clockdivider
References: <9edac4e26b9461b125012c7e025c847f@127.0.0.1>
In-Reply-To: <9edac4e26b9461b125012c7e025c847f@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Esben Haabendal wrote:
> Do rounding of brg clockdivider instead of truncate to get more precise baudrates

IIRC, the truncated divider produced better results with serial on 
mpc8272ads...

-Scott
