Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CC04DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 06:17:53 +1100 (EST)
Message-ID: <49D50F37.7070201@freescale.com>
Date: Thu, 02 Apr 2009 14:17:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] QE USB Host Integration for MPC832x
References: <1238622396-9768-1-git-send-email-marcel@ziswiler.com>	<20090402183357.GA29050@oksana.dev.rtsoft.ru>	<20090402183631.GA6699@oksana.dev.rtsoft.ru>	<49D5071D.50001@freescale.com>
	<20090402191159.GA14626@oksana.dev.rtsoft.ru>
In-Reply-To: <20090402191159.GA14626@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	linux-kernel@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Apr 02, 2009 at 01:42:37PM -0500, Timur Tabi wrote:
>> Anton Vorontsov wrote:
>>
>>> Oh, I was wrong. fsl_qe_udc driver uses mpc8360 compatible for
>>> matching, so you can't remove it. :-/
>> Ugh, that's a bug in the driver then.
> 
> Yes, but that depends on what chip was the first one? MPC8323 or
> MPC8360?

Actually, it depends on which one we picked in the devtree binding 
(assuming they're compatible both ways), which appears to be mpc8323.

-Scott
