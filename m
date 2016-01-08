Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427F11A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:12:16 +1100 (AEDT)
Message-ID: <1452219135.18702.0.camel@ellerman.id.au>
Subject: Re: [PATCH] misc: cxl: fix build for GCC 4.6.x
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian Norris <computersforpeace@gmail.com>, Joe Perches <joe@perches.com>
Cc: Michal Marek <mmarek@suse.com>, Anton Blanchard <anton@au1.ibm.com>, Ian
 Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Date: Fri, 08 Jan 2016 13:12:15 +1100
In-Reply-To: <20160107203839.GA42481@google.com>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
 <1452196651.4028.31.camel@perches.com> <20160107201826.GA120952@google.com>
 <20160107203839.GA42481@google.com>
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

On Thu, 2016-01-07 at 12:38 -0800, Brian Norris wrote:

> GCC 4.6.3 does not support -Wno-unused-const-variable. Instead, use the
> kbuild infrastructure that checks if this options exists.

Thanks.

> Also drop -Werror, since it's harmful, if forced on the user. New GCC's,
> or higher warning verbosities (e.g., W=1) can easily kill the build
> where they shouldn't.

But no thanks.

Please resend with just the cc-disable-warning change.

cheers
