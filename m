Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AF0FDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 23:29:06 +1000 (EST)
Message-Id: <272CD580-72C6-4671-8588-8385A4C2300F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080703112835.c082177b.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 06/12] net: use linux/of_{device,
	platform}.h instead of asm
Date: Tue, 8 Jul 2008 08:28:49 -0500
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
	<4864737D.80306@garzik.org>
	<C87095E8-991D-4730-8C5A-B132A3157727@kernel.crashing.org>
	<20080703112835.c082177b.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 8:28 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Wed, 2 Jul 2008 02:55:29 -0500 Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> I'll pick it up (since it mainly touches fsl enet controllers) if you
>> can repost it.  I seem to have lost the patch.
>
> Here you go.
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/

Thanks, there have been a number of changes so this doesn't apply  
anymore.  I'd suggest we hold on to it for a little while and let the  
driver churn calm down first.

- k
