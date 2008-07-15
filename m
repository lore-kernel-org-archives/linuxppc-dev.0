Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B532DE009
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:25:45 +1000 (EST)
Message-Id: <ACFB3A05-9DF3-4464-8FD8-9FECA52E8B38@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080611230402.GA21351@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/4] powerpc: fsl_uli1575: fix RTC quirk to work on
	MPC8572DS and MPC8610HPCD
Date: Tue, 15 Jul 2008 08:25:40 -0500
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
	<20080611230402.GA21351@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 6:04 PM, Anton Vorontsov wrote:

> This patch fixes RTC on MPC8572DS boards: dummy read helps only when
> reading at the end of the bridge's memory (i.e. outside of behind the
> bridge devices' assigned regions).
>
> With this change the quirk also makes RTC work on MPC8610HPCD, so it's
> unlikely that this will break MPC8641HPCN or MPC8544DS boards.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/fsl_uli1575.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied.

- k
