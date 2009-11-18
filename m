Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B30DCB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 00:11:20 +1100 (EST)
Date: Wed, 18 Nov 2009 05:11:29 -0800 (PST)
Message-Id: <20091118.051129.154107560.davem@davemloft.net>
To: sr@denx.de
Subject: Re: [PATCH] ibm_newemac: Fix EMACx_TRTR[TRT] bit shifts
From: David Miller <davem@davemloft.net>
In-Reply-To: <200911181107.51661.sr@denx.de>
References: <1258505815-31261-1-git-send-email-dmitchell@appliedmicro.com>
	<200911181107.51661.sr@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dmitchell@appliedmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>
Date: Wed, 18 Nov 2009 11:07:51 +0100

> On Wednesday 18 November 2009 01:56:55 Dave Mitchell wrote:
>> The TRT bit shifts were reversed for EMAC4 and non-EMAC4 during the
>> port from ibm_emac to ibm_newemac. This patch corrects that error.
>> 
>> Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
>> Acked-by: Feng Kan <fkan@appliedmicro.com>
>> Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> 
> Acked-by: Stefan Roese <sr@denx.de>
> 
> Would be great if this could go into 2.6.32. Thanks.

Applied to net-2.6, thanks.
