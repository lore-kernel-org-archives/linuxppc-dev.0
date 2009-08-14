Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAE0BB7FA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 06:21:25 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AFADDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 06:21:24 +1000 (EST)
Message-Id: <0170014F-1002-4138-9553-FAB6BB7402D5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/4] Remove second USB node from SBC834x DTS
Date: Fri, 14 Aug 2009 15:21:17 -0500
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 8:34 AM, Paul Gortmaker wrote:

> From: Liang Li <liang.li@windriver.com>
>
> Since only one of the SoC USB devices is brought out to a physical
> connector on the board, remove the 2nd (USB-DR) node from the DTS.
> Having it present and USB enabled will cause a hang at boot.
>
> Signed-off-by: Liang Li <liang.li@windriver.com>
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8349.dts |   12 ------------
> 1 files changed, 0 insertions(+), 12 deletions(-)


applied to next

- k
