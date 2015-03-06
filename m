Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 43CB31A0358
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 17:44:33 +1100 (AEDT)
Message-ID: <54F94CCD.8030807@c-s.fr>
Date: Fri, 06 Mar 2015 07:44:29 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 0/17] crypto: talitos - Add support for SEC1
References: <20150305164605.E65D81A241C@localhost.localdomain>
 <20150305182101.6db66e228f519476f0751c13@freescale.com>
In-Reply-To: <20150305182101.6db66e228f519476f0751c13@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/03/2015 01:21, Kim Phillips a écrit :
> On Thu, 5 Mar 2015 17:46:05 +0100
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>> [15/17] crypto: talitos - Implementation of SEC1
> ...
>
>> [16/17] crypto: talitos - SEC1 bugs on 0 data hash
>> [17/17] crypto: talitos - Update DT bindings with SEC1
> This patchseries doesn't apply, at least on top of Herbert's
> cryptodev-2.6 tree, as of today:
>
> Applying: crypto: talitos - Implementation of SEC1
> error: patch failed: drivers/crypto/talitos.c:655
> error: drivers/crypto/talitos.c: patch does not apply
It was applying ok on linux-next as of yesterday.
I will rebase the serie on cryptodev-2.6

Christophe
