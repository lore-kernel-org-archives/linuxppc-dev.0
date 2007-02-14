Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51AD2DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 02:55:16 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0702131409570.28978@ld2044.am.freescale.net>
References: <Pine.LNX.4.61.0702131409570.28978@ld2044.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C8A52CD5-626D-432D-BE8B-5503D56892B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/ppc: Drop use of SYNC macro in head_fsl_booke.S
Date: Wed, 14 Feb 2007 09:54:47 -0600
To: Becky Bruce <bgill@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2007, at 2:16 PM, Becky Bruce wrote:

> Eliminate needless invocation of the SYNC macro (which always  
> evaluates to
> nothing on BookE) from head_fsl_booke.S
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

applied

- k
