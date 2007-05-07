Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7645DDF27
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 06:01:24 +1000 (EST)
In-Reply-To: <463F83FC.6080807@freescale.com>
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<20F58AAE-A35D-4BEC-9597-A882567BA5B4@kernel.crashing.org>
	<463F83FC.6080807@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <95C59B89-6C1B-4989-B63C-8238561BE131@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
Date: Mon, 7 May 2007 15:00:25 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 2:54 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On May 7, 2007, at 1:29 PM, Scott Wood wrote:
>>> The magic packet flag indicates that the hardware has this
>>> capability.  The MDIO flag indicates that this device's
>>> registers contain active MDIO registers, and thus this
>>> device should not be put to sleep.
>> Can you explain the MDIO part further, do you mean its the tsec  
>> that  has the MDIO registers in its address space or that its  
>> actively  using MDIO for something?
>
> TSEC1 contains the MDIO registers for both TSEC1 and TSEC2.  Thus,  
> TSEC1 cannot be put to sleep if TSEC2 is active (plus, the phy  
> timer would have to be deactivated).  For now, the simple approach  
> of never sleeping TSEC1 is used.

That's what I guessed was the case, just wasn't clear from the comment.

- k
