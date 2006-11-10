Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9251E67E11
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 01:17:00 +1100 (EST)
In-Reply-To: <BAY102-F187E9196477E724317B9C6A9F70@phx.gbl>
References: <BAY102-F187E9196477E724317B9C6A9F70@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28501EDE-38C4-45FB-8B23-7E01A1815407@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Low memory not pageable on Freescale BookE
Date: Fri, 10 Nov 2006 08:17:00 -0600
To: "M Ptich" <ptich@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 10, 2006, at 2:14 AM, M Ptich wrote:

> For our application, we need low memory to be mapped with pages,  
> but it
> turned out that Freescale BookE maps it with TLB1. Was there any  
> particular
> reason why ? I am thinking of changing it, but wondering if there was
> something fundamental behind it.

Why do you need low kernel memory to be pageable?

- kumar
