Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5BF7DE5E6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:08:14 +1000 (EST)
Message-Id: <09E5A3EA-91A9-4E8E-B340-E586BCDB50C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <fc204cd230d4f00c1b5b618ecff4895157832c99.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 08/14] powerpc: Split out do_feature_fixups() from
	cputable.c
Date: Tue, 24 Jun 2008 08:48:29 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<fc204cd230d4f00c1b5b618ecff4895157832c99.1214271072.git.michael@ellerman.id.au>
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

> The logic to patch CPU feature sections lives in cputable.c, but  
> these days
> it's used for CPU features as well as firmware features. Move it into
> it's own file for neatness and as preparation for some additions.
>
> While we're moving the code, we pull the loop body logic into a  
> separate
> routine, and remove a comment which doesn't apply anymore.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>


Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
