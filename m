Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410WBK07DyzF1nX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 22:21:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] powerpc: fix build failure by disabling attribute-alias
 warning
In-Reply-To: <0332913c-04c0-362f-313f-8d42099f168d@c-s.fr>
References: <40zxgb4SmTz9s7c@ozlabs.org>
 <0332913c-04c0-362f-313f-8d42099f168d@c-s.fr>
Date: Tue, 05 Jun 2018 22:21:27 +1000
Message-ID: <87wovdmnjs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 04/06/2018 =C3=A0 16:11, Michael Ellerman a =C3=A9crit=C2=A0:
>> On Tue, 2018-05-29 at 16:06:41 UTC, Christophe Leroy wrote:
>>> Latest GCC version emit the following warnings
>>>
>>> As arch/powerpc code is built with -Werror, this breaks build with
>>> GCC 8.1
>>>
....
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>=20
>> Applied to powerpc next, thanks.
>>=20
>> https://git.kernel.org/powerpc/c/2479bfc9bc600dcce7f932d52dcfa8
>
> Oops, you didn't take v4 but v3 which was missing the fix into pci_32.c

Yep sorry. I had v3 in my tree since a few days.

If the patch is "Under Review" in patchwork that usually means I have it
applied and am testing it. Although sometimes I forget :)

> I'll send you a patch to add the fix in pci_32.c

Thanks, applied.

cheers
