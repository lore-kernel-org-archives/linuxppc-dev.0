Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B13D0DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 15:33:00 +1000 (EST)
In-Reply-To: <20070808170728.GA21118@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3355D291-B917-48F0-A6C5-319E52EE7F29@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 0/2] SPI support for fsl_soc and mpc832x_rdb
Date: Thu, 9 Aug 2007 00:34:28 -0500
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 8, 2007, at 12:07 PM, Anton Vorontsov wrote:

> Hi all,
>
> This is v3. The only objection I can imagine is about "fsl,device-id".
> Though in the v2 nobody complained, thus it's stayed intact.
>
> If you want to, complain now. I'll give up and will remove it. ;-)

:), here's my complaint for it.

We should just use the physical address of the bus register base as  
the id.  We do the same thing for the MII phy bus driver for gianfar.

- k
