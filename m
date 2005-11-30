Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DBAC68854
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 16:51:47 +1100 (EST)
In-Reply-To: <20051128141042.GR7163@cathedrallabs.org>
References: <20051128141042.GR7163@cathedrallabs.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46ED525E-5C26-4311-87DE-FE55AE8DE0F0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 29 Nov 2005 23:51:45 -0600
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] add PHY support to AM79C874
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would suggest sending this to the netdev list for review and  
acceptance.

- kumar

On Nov 28, 2005, at 8:10 AM, Aristeu Sergio Rozanski Filho wrote:

> This is a simple port from old fec driver to PHY layer to support AMD
> AM79C874 PHY.
> As I don't have the hardware to test this, all kinds of feedback are
> most welcome.
> Thanks,
>
> -- 
> Aristeu
>
> <phy-add_am79c874_phy.patch>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
