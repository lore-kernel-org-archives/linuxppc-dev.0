Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRHxQ6hKMzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 12:13:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
In-Reply-To: <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
References: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
 <b6b5f2f0-bbfe-8471-d8fc-e236ea0b1ea4@infradead.org>
 <dd16f28c-1613-cfb2-5349-07aaac2f2f5a@users.sourceforge.net>
 <8d140d00-935c-da0a-ff2e-167abe642bda@infradead.org>
 <32cdcd8a-1000-223c-71da-4c9119954d4e@users.sourceforge.net>
 <3a657b44-2bc8-ee05-3a42-db7af354967e@infradead.org>
 <57b472a0-0245-f821-cea8-171c34cc9df7@users.sourceforge.net>
Date: Tue, 08 Aug 2017 12:13:12 +1000
Message-ID: <87shh2olhj.fsf@concordia.ellerman.id.au>
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

SF Markus Elfring <elfring@users.sourceforge.net> writes:

>>>> I didn't consider one would be triggered by the kzalloc failure.
>>>
>>> Do you reconsider any special system settings for further
>>> software evolution then?
>>=20
>> Sorry, I don't quite understand your question.
>
> Do you try to configure the Linux error reporting to any special needs?
>
>
>> I think your original patch is OK,
>
> How does this feedback fit to the initial response =E2=80=9CNot Applicabl=
e=E2=80=9D?
> https://patchwork.ozlabs.org/patch/798575/

That comes from me, and means "I can't apply this patch", because it's
not a powerpc patch.

Looking at the maintainers output though maybe that is meant to go via
the powerpc tree.

cheers
