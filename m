Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkT2c5C7FzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:54:48 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id p189so209176pfp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:54:48 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Cc: anton@samba.org
Subject: Re: [PATCH 1/4] crypto: powerpc - Factor out the core CRC vpmsum
 algorithm
In-Reply-To: <87y3w5jy8y.fsf@concordia.ellerman.id.au>
References: <20170315123737.20234-1-dja@axtens.net>
 <87y3w5jy8y.fsf@concordia.ellerman.id.au>
Date: Thu, 16 Mar 2017 23:54:41 +1100
Message-ID: <87tw6ttm9a.fsf@possimpible.ozlabs.ibm.com>
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

> So although this sits in arch/powerpc, it's heavy on the crypto which is
> not my area of expertise (to say the least!), so I think it should
> probably go via Herbert and the crypto tree?

That was my thought as well. Sorry - probably should have put that in
the comments somewhere.

Regards,
Daniel
