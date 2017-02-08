Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJGDG2yKLzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:31:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/powernv: Properly set "host-ipi" on IPIs
In-Reply-To: <1486427736.4850.103.camel@kernel.crashing.org>
References: <1486427736.4850.103.camel@kernel.crashing.org>
Date: Wed, 08 Feb 2017 20:31:09 +1100
Message-ID: <877f519ggy.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Otherwise KVM will fail to pass them through to the host

OK, so this is:

Fixes: d74361881f0d ("powerpc/xics: Add ICP OPAL backend")

But seeing as the KVM support is only going into v4.11, I won't tag it
for stable.

Paul do you want me to put this in the topic branch?

cheers
