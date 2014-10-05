Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6847C1A07D8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Oct 2014 11:40:39 +1100 (EST)
Date: Sat, 4 Oct 2014 19:39:25 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 03/20] powerpc/47x: Use pm_power_off rather than
 ppc_md.power_off
Message-ID: <20141005003925.GA26256@gate.crashing.org>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
 <1412170086-57971-4-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412170086-57971-4-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 01, 2014 at 03:27:49PM +0200, Alexander Graf wrote:
> diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
> index 33986c1..7027015 100644
> --- a/arch/powerpc/platforms/44x/ppc476.c
> +++ b/arch/powerpc/platforms/44x/ppc476.c
> @@ -94,7 +94,7 @@ static int avr_probe(struct i2c_client *client,
>  {
>  	avr_i2c_client = client;
>  	ppc_md.restart = avr_reset_system;
> -	ppc_md.power_off = avr_power_off_system;
> +	pm_power_off = avr_power_off_system
>  	return 0;
>  }

That doesn't compile afaics?


Segher
