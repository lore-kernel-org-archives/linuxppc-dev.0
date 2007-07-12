Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE60EDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:01:31 +1000 (EST)
In-Reply-To: <1184190325.25384.125.camel@ld0161-tx32>
References: <1184190325.25384.125.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BFA74155-D32C-41F5-B61C-D9CE89A29B9B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Move DTC Technical specs out of b-w-o.txt into DTC
	Repo
Date: Thu, 12 Jul 2007 02:01:07 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 11, 2007, at 4:45 PM, Jon Loeliger wrote:

> Folks,
>
> Here are two patches, one to the kernel, the other to
> the DTC repo, that moves the technical description
> portions of the booting-without-of.txt documentation
> out of the kernel and into the DTC repository.

Why remove it from the kernel?  It seems like this part should change  
infrequently and it would be good to keep its documentation with the  
kernel as well?

- k
