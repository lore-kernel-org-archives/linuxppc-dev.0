Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99F48DE7E2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 00:55:16 +1000 (EST)
Message-Id: <300E659E-810B-4C90-A8C8-78E39B73D8B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1215611076-13518-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with more
	than 2GB of RAM
Date: Wed, 9 Jul 2008 09:20:25 -0500
References: <1215611076-13518-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 8:44 AM, Stefan Roese wrote:

> This patch enables 32bit PPC's (with 36bit physical address space,  
> e.g.
> IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
> replacing types (unsigned long -> phys_addr_t).

should the commit header really be >= 4G.  I don't think there is any  
issue with 2-4G support as it stands.
>
>
> Tested on an AMCC Katmai with 4GB of DDR2.
>
> Signed-off-by: Stefan Roese <sr@denx.de>

- k
