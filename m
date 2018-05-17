Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40msjB3kgRzF283
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:34:22 +1000 (AEST)
Date: Thu, 17 May 2018 08:33:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/lib: move PPC32 specific functions out of
 string.S
Message-ID: <20180517133352.GS17342@gate.crashing.org>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <68d0167111d06a8b21d7e52140bf399d79979e3b.1526553552.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68d0167111d06a8b21d7e52140bf399d79979e3b.1526553552.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2018 at 12:49:50PM +0200, Christophe Leroy wrote:
> In preparation of optimisation patches, move PPC32 specific
> memcmp() and __clear_user() into string_32.S

> --- /dev/null
> +++ b/arch/powerpc/lib/string_32.S
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * String handling functions for PowerPC32
> + *
> + * Copyright (C) 2018 CS Systemes d'Information
> + *
> + * Author: Christophe Leroy <christophe.leroy@c-s.fr>
> + *
> + */

That is wrong; that code is a plain copy, from 1996 already.


Segher
