Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzSHn3NC3zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 14:05:09 +1000 (AEST)
Message-ID: <1462248309.12788.4.camel@ellerman.id.au>
Subject: Re: [PATCH v3 12/16] rtc: powerpc: provide rtc_class_ops directly
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
 dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org,
 a.zummo@towertech.it, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org,  linux-m68k@lists.linux-m68k.org,
 rtc-linux@googlegroups.com,  linux-arch@vger.kernel.org
Date: Tue, 03 May 2016 14:05:09 +1000
In-Reply-To: <1461796470-1291527-13-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <1461796470-1291527-13-git-send-email-arnd@arndb.de>
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

On Thu, 2016-04-28 at 00:34 +0200, Arnd Bergmann wrote:

> The rtc-generic driver provides an architecture specific
> wrapper on top of the generic rtc_class_ops abstraction,
> and powerpc has another abstraction on top, which is a bit
> silly.
> 
> This changes the powerpc rtc-generic device to provide its
> rtc_class_ops directly, to reduce the number of layers
> by one.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/time.c | 29 ++++++++++++++++++++++++++++-
>  drivers/rtc/rtc-generic.c  |  2 +-
>  2 files changed, 29 insertions(+), 2 deletions(-)

If this hits linux-next it will go through my automated boot testing, which
hopefully would be sufficient to catch any bugs in this patch, cross fingers.

I don't know jack about all the layers of RTC mess, so my ack is basically
worthless here. But if you like you can have one anyway :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
