Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQ7p1bWpzDqr6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:44:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Cc: anton@samba.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 2/4] crypto: powerpc - Re-enable non-REFLECTed CRCs
In-Reply-To: <20170315123737.20234-2-dja@axtens.net>
References: <20170315123737.20234-1-dja@axtens.net>
 <20170315123737.20234-2-dja@axtens.net>
Date: Thu, 16 Mar 2017 21:44:03 +1100
Message-ID: <871stxlcwc.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> When CRC32c was included in the kernel, Anton ripped out
> the #ifdefs around reflected polynomials, because CRC32c
> is always reflected. However, not all CRCs use reflection
> so we'd like to make it optional.
>
> Restore the REFLECT parts from Anton's original CRC32
> implementation (https://github.com/antonblanchard/crc32-vpmsum)
>
> That implementation is available under GPLv2+, so we're OK
> from a licensing point of view:
> https://github.com/antonblanchard/crc32-vpmsum/blob/master/LICENSE.TXT

It's also written by Anton and copyright IBM, so you (we (IBM)) could
always just relicense it anyway.

So doubly OK IMO.

cheers
