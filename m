Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zS2PR2SpHzDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 00:07:06 +1100 (AEDT)
Date: Thu, 25 Jan 2018 14:07:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 arnd@arndb.de, mpe@ellerman.id.au, andrew.donnellan@au1.ibm.com,
 alastair@au1.ibm.com
Subject: Re: [PATCH v2 07/13] ocxl: Add AFU interrupt support
Message-ID: <20180125130703.GA8576@kroah.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
 <20180123113148.6024-8-fbarrat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123113148.6024-8-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 23, 2018 at 12:31:42PM +0100, Frederic Barrat wrote:
> --- /dev/null
> +++ b/drivers/misc/ocxl/afu_irq.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2017 IBM Corp.

What year is it again?

:)
