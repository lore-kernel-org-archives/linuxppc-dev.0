Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D064DE0F8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:23:16 +1000 (EST)
Message-Id: <0C4694A6-CCCA-4236-92FC-D498E40E6A31@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <e1b874df92f61cbd3c25bd90f6e48784dc1f632b.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 03/14] powerpc: Make create_branch() return errors if the
	branch target is too large
Date: Tue, 24 Jun 2008 08:21:00 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<e1b874df92f61cbd3c25bd90f6e48784dc1f632b.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> If you pass a target value to create_branch() which is more than  
> 32MB - 4,
> or - 32MB away from the branch site, then it's impossible to create an
> immediate branch. The current code doesn't check, which will lead to  
> us
> creating a branch to somewhere else - which is bad.
>
> For code that cares to check we return 0, which is easy to check  
> for, and
> for code that doesn't at least we'll be creating an illegal  
> instruction,
> rather than a branch to some random address.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
