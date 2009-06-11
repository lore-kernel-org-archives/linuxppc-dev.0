Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 66334B7298
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 14:33:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9033DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 14:33:49 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: mware@internode.on.net
In-Reply-To: <38410.1244689279@internode.on.net>
Subject: Re: [PATCH] powerpc/fsl_lbc: Increase the number of possible lbc banks
References: <38410.1244689279@internode.on.net>
Message-Id: <ABADE46C-FAEF-4206-A948-1ECC62D28295@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 10 Jun 2009 23:33:23 -0500
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 10:01 PM, mware@internode.on.net wrote:

> Currently the fsl,*lbc devices support 8 banks (ie OR and BR  
> registers).
> This is adequate for most pq2 and pq3 processors, but not the  
> MPC8280 which
> has 12 banks.
>
> Signed-Off-By: Mark Ware <mware@elphinstone.net>
> ---
> arch/powerpc/include/asm/fsl_lbc.h |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

fsl_lbc is not applicable to the MPC8280.  Its only used for MPC83xx,  
MPC85xx, and MPC86xx.

- k
