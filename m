Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 634B31007D4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 21:08:01 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ibm_newemac: Fix EMACx_TRTR[TRT] bit shifts
Date: Wed, 18 Nov 2009 11:07:51 +0100
References: <1258505815-31261-1-git-send-email-dmitchell@appliedmicro.com>
In-Reply-To: <1258505815-31261-1-git-send-email-dmitchell@appliedmicro.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200911181107.51661.sr@denx.de>
Cc: netdev@vger.kernel.org, Dave Mitchell <dmitchell@appliedmicro.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 18 November 2009 01:56:55 Dave Mitchell wrote:
> The TRT bit shifts were reversed for EMAC4 and non-EMAC4 during the
> port from ibm_emac to ibm_newemac. This patch corrects that error.
> 
> Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
> Acked-by: Feng Kan <fkan@appliedmicro.com>
> Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>

Acked-by: Stefan Roese <sr@denx.de>

Would be great if this could go into 2.6.32. Thanks.

Cheers,
Stefan
