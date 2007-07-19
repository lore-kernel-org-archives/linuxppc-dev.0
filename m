Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9512FDDEC2
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 05:04:33 +1000 (EST)
In-Reply-To: <469FB3C4.8070909@freescale.com>
References: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
	<F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
	<20070719205745.57f9d5a0@localhost.localdomain>
	<B71D432E-5C61-4873-9B35-9C7825AABCBD@kernel.crashing.org>
	<469FB3C4.8070909@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6F5AD02-8D6B-4D90-93BF-D3711627FE8C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 49/61] 8xx: Update device trees.
Date: Thu, 19 Jul 2007 21:04:17 +0200
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

>> Since you are using generic names, the only use for the "name"
>> of a node is for a human reader to understand your tree.  Maybe
>> everyone using this specific SoC knows what a BCSR is; or maybe
>> there is a more friendly name you could use.
>
> It's the standard term used in Freescale board documentation.  I  
> could change it to board-control, though.

That sounds nice and generic, I like it.


Segher
