Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94DE6B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 14:38:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5333DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 14:38:36 +1000 (EST)
Message-Id: <B86B0653-311C-49EA-B27F-F5AB98D49401@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] sbc8560: Fix warm reboot with board specific reset
	function
Date: Thu, 13 Aug 2009 23:38:30 -0500
References: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 13, 2009, at 6:06 PM, Paul Gortmaker wrote:

> From: Liang Li <Liang.Li@windriver.com>
>
> The existing fsl_rstcr_restart function fails to reset the sbc8560
> board. This implements a board specific reset function that uses
> the RCR(Reset Control Register) of the board's EPLD to do a reset.
>
> Signed-off-by: Liang Li <Liang.Li@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/85xx/sbc8560.c |   39 ++++++++++++++++++++++++ 
> ++++++++-
> 1 files changed, 38 insertions(+), 1 deletions(-)

The reason it didn't was that feature doesnt exist on the mpc8560 :)

- k
