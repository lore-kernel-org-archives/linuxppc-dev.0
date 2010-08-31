Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id E653CB6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 16:14:18 +1000 (EST)
Received: by qyk1 with SMTP id 1so4373270qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 23:14:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
	<20100830132914.GA32266@oksana.dev.rtsoft.ru>
	<AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
	<AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
Date: Tue, 31 Aug 2010 08:14:16 +0200
Message-ID: <AANLkTimwqvE3ssqaqfe40V+51dRTxndqroBQUK9js_NR@mail.gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>, linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 30, 2010 at 7:46 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Mon, Aug 30, 2010 at 10:04 AM, Esben Haabendal
>> Hopefully, arm users will soon enjoy this driver/wrapper soon also.
>
> My hope is that even on ARM when the device tree is used I'll be able
> eliminate IRQs mapped to 0 (but I need to do a lot more research on
> how best to do that though). =A0Are you actually using this on ARM?

No.

> I'm okay with you keeping the NO_IRQ test for the short term though.

Ok.  I personally don't see a big problem with dropping it either, as
I don't actually
use it on ARM. But until at least ARM has NO_IRQ=3D=3D0, I just thought it =
would be
the right thing to try to be compatible.

/Esben
