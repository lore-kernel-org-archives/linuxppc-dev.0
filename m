Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F773DDE98
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 08:09:21 +1000 (EST)
In-Reply-To: <20071005174015.GA11016@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27C7E568-B28A-4659-803F-9D271B2E1AF6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH respin 0/7] MPC8568E-MDS related patches
Date: Fri, 5 Oct 2007 17:09:28 -0500
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


On Oct 5, 2007, at 12:40 PM, Anton Vorontsov wrote:

> Hello Kumar,
>
> This is respin of MPC8568E-MDS patches, on top of master branch
> as of today.
>
> If there are no objections against SPI patch, please Ack it, thus
> David could pick it up.

I've applied patches 1-5 however I'm not able to get UCC enet working  
on my board.  Is there something special that has to be done?  (I've  
got the card standalone, no MDS backplane).

I'm using the 1.3.0-rc2 u-boot w/o any modifications.

Also, I tried a PCIe e1000 card w/the .dts that's in my tree and that  
works w/o any issue.

- k
