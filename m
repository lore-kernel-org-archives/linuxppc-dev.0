Return-Path: <pombredanne@nexb.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0n6q0bydzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 03:48:50 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id g130so8301087wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 08:48:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7a59e8575bcb8c2de4a68be688fb2a4d0699d61b.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <7a59e8575bcb8c2de4a68be688fb2a4d0699d61b.1513608243.git.fbarrat@linux.vnet.ibm.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 18 Dec 2017 17:48:05 +0100
Message-ID: <CAOFm3uGpELv+X+DdESofnFqQZDw7V4TcCg3v5NHX3cVCFxQP_A@mail.gmail.com>
Subject: Re: [PATCH 09/13] ocxl: Add trace points
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 mpe@ellerman.id.au, andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic,

On Mon, Dec 18, 2017 at 4:21 PM, Frederic Barrat
<fbarrat@linux.vnet.ibm.com> wrote:
> Define a few trace points so that we can use the standard tracing
> mechanism for debug and/or monitoring.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

<snip>

> --- /dev/null
> +++ b/drivers/misc/ocxl/trace.h
> @@ -0,0 +1,189 @@
> +/*
> + * Copyright 2017 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

Would you mind using the new SPDX tags documented in Thomas patch set
[1] rather than this legalese?

Thank you!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
