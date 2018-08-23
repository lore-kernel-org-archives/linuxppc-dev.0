Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xJ3v5x5HzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 07:50:03 +1000 (AEST)
Message-ID: <4557653efa685ffc0533f7168a628491ad843e01.camel@kernel.crashing.org>
Subject: Re: DT case sensitivity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Grant Likely <grant.likely@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Kumar Gala <kumar.gala@linaro.org>, David Gibson
 <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 24 Aug 2018 07:49:19 +1000
In-Reply-To: <20180823121929.GS24439@gate.crashing.org>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <20180823121929.GS24439@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 07:19 -0500, Segher Boessenkool wrote:
> If one implementation does case insensitive, it will most likely just work,
> because people do not make insane names differing only in case on purpose.

Apple did :-)

ide, vs IDE, ata vs ATA, I've seen all sort of crap there, esp. on old
machines.

> Now people write other things that they only test against that implementation,
> and those things now only work with case-insensitive.  And you do not know
> without testing if anything breaks.  (But the laws of big numbers are against
> you here).  Since there isn't really a drawback to doing case-insensitive
> always, that is a much safer way forward, much less work for everyone, even
> if technically the wrong thing to do :-)
> 
> 
> Segher
