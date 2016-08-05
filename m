Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5MDw1mTHzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 19:38:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>, Scott Wood <oss@buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, antoine.blangy@c-s.fr,
 segher@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
In-Reply-To: <ab39b1b1-2320-31ba-3f19-11a62e3586b8@c-s.fr>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
 <1470282813.25630.242.camel@buserror.net>
 <CAPk1OjHjVKOhh_WfnYnkb+1abyBzzHkOO_H2rFx3KMhe0yc+0Q@mail.gmail.com>
 <87shujitxx.fsf@concordia.ellerman.id.au>
 <ab39b1b1-2320-31ba-3f19-11a62e3586b8@c-s.fr>
Date: Fri, 05 Aug 2016 19:38:23 +1000
Message-ID: <87eg63imi8.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 05/08/2016 =C3=A0 08:57, Michael Ellerman a =C3=A9crit :
>> Alessio Igor Bogani <alessio.bogani@elettra.eu> writes:
>>> On 4 August 2016 at 05:53, Scott Wood <oss@buserror.net> wrote:
>>>> On Tue, 2016-08-02 at 10:07 +0200, Christophe Leroy wrote:
>>>>> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>>>>> based on copy_tofrom_user()") introduced a bug when destination
>>>>> address is odd and initial csum is not null
>>>>>
>
> The purpose of this patch was not to address Alessio's issue, but to fix=
=20
> a huge issue on checksum calculation which induces breakdown of TCP=20
> connections.
>
> I think it is worth commiting it upstream and on impacted stable=20
> releases, allthought we don't have yet identified the issue Alessio's has.

OK. I'll put it back into fixes on Monday if I haven't heard anything
further.

cheers
