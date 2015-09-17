Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D09D1A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 03:50:57 +1000 (AEST)
Message-ID: <1442512248.3837.61.camel@infradead.org>
Subject: Re: Time to remove platforms/cell?
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 17 Sep 2015 10:50:48 -0700
In-Reply-To: <1442484325.26748.7.camel@ellerman.id.au>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2023345.Irprl084gX@fb07-iapwap2> <7144823.dIR0EDXkmx@wuerfel>
 <1442484325.26748.7.camel@ellerman.id.au>
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

On Thu, 2015-09-17 at 20:05 +1000, Michael Ellerman wrote:

> Right. I wouldn't bet money that the oprofile code still works, but spufs
> definitely would have to stay.

oprofile on PS3 needed additional patches [1] that I never
merged upstream, and no longer plan to, so oprofile support
should be removed.

If someone in the future needs oprofile it wouldn't be too
hard to get what is there now working again. 

[1] http://git.kernel.org/cgit/linux/kernel/git/geoff/ps3-linux.git/log/?h=ps3-queue-v3.7

-Geoff
