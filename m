Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7218B1A028D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 08:19:42 +1100 (AEDT)
Message-ID: <1452719981.8203.2.camel@ellerman.id.au>
Subject: Re: [PATCH 2/5] misc: cxl: use kobj_to_dev()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geliang Tang <geliangtang@163.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Jan 2016 08:19:41 +1100
In-Reply-To: <6e8fbf9983f218aa373b870aa842f028a7bbc144.1452698603.git.geliangtang@163.com>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
 <6e8fbf9983f218aa373b870aa842f028a7bbc144.1452698603.git.geliangtang@163.com>
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

On Wed, 2016-01-13 at 23:30 +0800, Geliang Tang wrote:
> Use kobj_to_dev() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/misc/cxl/sysfs.c | 5 ++---

Looks fine. Do you want me to merge it or just ack it?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
