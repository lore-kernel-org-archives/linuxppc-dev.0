Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BljB2jpJzDqph
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 00:19:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shea Levy <shea@shealevy.com>, Joe Perches <joe@perches.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <874lkzudkc.fsf@xps13.shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-15-shea@shealevy.com>
 <1522269853.12357.135.camel@perches.com> <874lkzudkc.fsf@xps13.shealevy.com>
Date: Fri, 30 Mar 2018 00:19:40 +1100
Message-ID: <87a7ur10k3.fsf@concordia.ellerman.id.au>
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

Shea Levy <shea@shealevy.com> writes:

> Joe Perches <joe@perches.com> writes:
>
>> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>
>> Most people seem to want some form of commit message
>> and not just your sign-off.
>>
>
> Ah, if the subject is insufficient I can add some more detail.

Yeah please do.

Seeing this patch in isolation, with no change log, I might think it's
safe for me to just apply it.

But that would break the build because I don't have patch 1.

So for starters you need to explain that part, eg something like:

  A previous patch in the series added a weak definition of
  free_initrd_mem() in init/initramfs.c.

  The powerpc implementation is identical, so it can be removed allowing
  the generic version to be used.


Then you could also tell me if you did/didn't build/boot test it.

cheers
