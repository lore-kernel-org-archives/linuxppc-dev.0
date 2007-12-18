Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53C7CDDE16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Dec 2007 03:25:21 +1100 (EST)
Message-ID: <4767F2FD.30708@freescale.com>
Date: Tue, 18 Dec 2007 10:19:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: USB configuration
References: <14192347.post@talk.nabble.com>	<20071217213341.630cbdf5@kernel.crashing.org>
	<14389002.post@talk.nabble.com>
In-Reply-To: <14389002.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Misbah khan wrote:
> hi ...
> 
> The montavista version we are using is " 2.6.10_mvl401-8272ads " 
> 
> Montavista people says that they are supporting USB host interface ....

If MV claims that they support the MPC82xx USB host controller, then you 
should be talking to MV... it's not supported in the mainline kernel.

-Scott
