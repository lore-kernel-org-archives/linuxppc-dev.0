Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75526DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:03:30 +1000 (EST)
Message-Id: <771B1F79-194B-4C6A-A2AE-5E4BEF0A17D3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <95c5ebd63992c64ad0b644f1204362aaf5e35eeb.1239025478.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/oprofile: dump_pmcs() is not used
Date: Mon, 6 Apr 2009 09:03:16 -0500
References: <95c5ebd63992c64ad0b644f1204362aaf5e35eeb.1239025478.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2009, at 8:45 AM, Michael Ellerman wrote:

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/oprofile/op_model_fsl_emb.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
> Or should we just remove it?

I'm for removing it if Andy doesn't have any issues.  Someone can  
always add it back as debugfs code in the future if they want it.

- k
