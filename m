Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A0C1DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 15:46:48 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add MSR[CE, DE] to the MSR bits we print on
	show_regs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1227105593-29462-1-git-send-email-galak@kernel.crashing.org>
References: <1227105593-29462-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 15:46:42 +1100
Message-Id: <1227156402.7185.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-19 at 08:39 -0600, Kumar Gala wrote:
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

Shouldn't this be protected by some ifdef ?

Ben.

>  arch/powerpc/kernel/process.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 957bded..b038323 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -467,6 +467,8 @@ static struct regbit {
>  	{MSR_VEC,	"VEC"},
>  	{MSR_VSX,	"VSX"},
>  	{MSR_ME,	"ME"},
> +	{MSR_CE,	"CE"},
> +	{MSR_DE,	"DE"},
>  	{MSR_IR,	"IR"},
>  	{MSR_DR,	"DR"},
>  	{0,		NULL}
