Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjB7w5F0rzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 11:40:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: remove CLASS_ATTR usage
In-Reply-To: <20170606133203.GA7518@kroah.com>
References: <20170606133203.GA7518@kroah.com>
Date: Wed, 07 Jun 2017 11:40:12 +1000
Message-ID: <87k24opocj.fsf@concordia.ellerman.id.au>
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

Greg KH <gregkh@linuxfoundation.org> writes:

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> There was only 2 remaining users of CLASS_ATTR() so let's finally get
> rid of them and force everyone to use the correct RW/RO/WO versions
> instead.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> PPC maintainers, can I take this in my driver core tree?  I'm doing some
> cleanups of device.h and this was one of the simpler ones at the moment.

Yeah looks good to me, I did a quick build test and it was OK.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
