Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8649ADDF48
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 00:43:44 +1000 (EST)
In-Reply-To: <47011BED.8020206@freescale.com>
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
	<47011BED.8020206@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Date: Tue, 2 Oct 2007 09:43:38 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: Timur Tabi <timur@freescale.com>,
	PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 1, 2007, at 11:10 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Sep 29, 2007, at 1:49 AM, Vitaly Bordug wrote:
>>> cpms have dpram, qe has muram. these two are the same stuff in  
>>> fact. Or you are asking about have QE stuff utilize such a  
>>> binding at the same pass?
>> I was asking about both these things.
>
> As stated in the commit message, QE can use this; it just needs a  
> compatible entry in the data node.

can some one look at that.

- k
