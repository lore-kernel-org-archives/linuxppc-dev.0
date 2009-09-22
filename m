Return-Path: <prodyuth@gmail.com>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id 14DD1B7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 10:28:36 +1000 (EST)
Received: by pzk15 with SMTP id 15so384643pzk.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Sep 2009 17:28:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1253578361.7103.180.camel@pasglop>
References: <1253573245-1867-1-git-send-email-phazarika@amcc.com>
	<1253576514.7103.165.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D606FFE802@SDCEXCHANGE01.ad.amcc.com>
	<1253578361.7103.180.camel@pasglop>
Date: Mon, 21 Sep 2009 17:28:35 -0700
Message-ID: <49c0ff980909211728s2d39e356p6900d047c6918826@mail.gmail.com>
Subject: Re: [PATCH 1/2] ibm_newemac: Add Support for MAL Interrupt Coalescing
From: prodyut hazarika <prodyuth@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>,
	netdev@vger.kernel.org, lada.podivin@gmail.com,
	Loc Ho <lho@amcc.com>, bhutchings@solarflare.com,
	Prodyut Hazarika <phazarika@amcc.com>,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

>
> BTW. If you guys are ever going to do another change to MAL, please
> please plase, add the -one- major missing feature that's causing all the
> pain and complication in the current design: Add a per-channel interrupt
> masking option.
>
> The lack of ability to mask the interrupt per MAL channel is what forces
> us to create that fake netdev structure in order to share the napi
> device instance between all the EMACs in the system. This is very
> inefficient too. We would be able to make things run a lot smoother if
> we could just have a napi instance per EMAC, but for that, we need
> per-channel interrupt masking.
>

I will add a patch for the above as soon as I am done incorporating
your comments on the MAL coalescing support.

Thanks
Prodyut
