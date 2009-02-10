Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F159DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 08:57:32 +1100 (EST)
Message-ID: <4991F808.9090001@freescale.com>
Date: Tue, 10 Feb 2009 15:56:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Coulter <scott.coulter@cyclone.com>
Subject: Re: 2.6.27.6 kernel Bad trap boot problem on MPC8568E
References: <43EB80E07C42E1408726E4905FB96B04C07522@CYBORG3.cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C07522@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Coulter wrote:
> Bad trap at PC: 100b7354, SR: 2d000, vector=2020
> init has generated signal 5 but has no handler for it
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 180 seconds..
> 
> I am not using a debugger, so I can't see where the SIGTRAP would be coming from.

That's an SPE Unavailable exception.  Try enabling CONFIG_SPE.

-Scott
