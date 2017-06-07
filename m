Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wjP6K2GfxzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 19:54:33 +1000 (AEST)
Date: Wed, 7 Jun 2017 11:54:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 1/3] EDAC: mv64x60: check driver registration success
Message-ID: <20170607095417.qorkbwm5u5saplb2@pd.tnic>
References: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
 <20170529212142.25572-2-chris.packham@alliedtelesis.co.nz>
 <7b51ad125caf4d4c97157187510626cc@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7b51ad125caf4d4c97157187510626cc@svr-chch-ex1.atlnz.lc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2017 at 05:29:55AM +0000, Chris Packham wrote:
> What do you think?

Just send me a fix ontop, moving the edac_op_state assignment before the
platform_register_drivers() call and write in the commit message why
we're doing that.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
