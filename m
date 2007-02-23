Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 331D8DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 03:15:18 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
	<20070223003317.GA18508@localhost.localdomain>
	<1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9A50C65C-7E90-4F3C-B49B-EE2BCE83168D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 10:14:08 -0600
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 23, 2007, at 10:07 AM, Yoder Stuart-B08248 wrote:

>
>>> we need something like interrupt-array.
>>
>> Again, the "interrupt-array" helps only this one specific
>> case, and not the general case *at all*.
>>
>
> Yes-- The interrupt-array helps only this specific case. But
> the question is, will this specific case be common in the
> future?
>
> If this is a one-off situation it doesn't warrant a new
> general property.  However, if it becomes common enough
> a simpler representation will benefit developers.  There are
> developers who have a hard enough time figuring out the
> interrupt-map scheme, much less a logical interrupt nexus
> node.

But how often are developers going to have to tweak these things?   
SoC interrupts tend to be fixed so its just a question of external  
interrupts (and controllers) that a customer has to describe in their  
dts.

- k
