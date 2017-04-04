Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy5sm3kNmzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 21:12:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au,
 ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Subject: Re: [PATCH 2/5] crypto/nx: Create nx842_cfg_crb function
In-Reply-To: <1491066000.29552.27.camel@hbabu-laptop>
References: <1491066000.29552.27.camel@hbabu-laptop>
Date: Tue, 04 Apr 2017 21:12:27 +1000
Message-ID: <87fuhov338.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> writes:

> [PATCH 2/5] crypto/nx: Create nx842_cfg_crb function
>
> Configure CRB is moved to nx842_cfg_crb() so that it can be
> used for icswx function and VAS function which will be added
> later.

Buy a vowel! :)

nx842_configure_crb() is fine.

cheers
