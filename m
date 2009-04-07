Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7B60DE204
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:19:11 +1000 (EST)
Message-Id: <3E703396-227B-4599-B30B-DFBFADBBAB81@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49BE1497.6070004@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 3/3] PowerPC: MPC85xx: TQM8548: update defconfig
Date: Tue, 7 Apr 2009 01:19:02 -0500
References: <49BE1497.6070004@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 3:57 AM, Wolfgang Grandegger wrote:

> Enable highmem support for the TQM8548-AG modules and NAND support for
> the TQM8548-BE modules. Furthermore disable USB, Wireless and IDE  
> support
> because it's not available on the STK85xx starter kit.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/configs/85xx/tqm8548_defconfig |  164 +++++++ 
> +-------------------
> 1 files changed, 48 insertions(+), 116 deletions(-)


applied

- k
