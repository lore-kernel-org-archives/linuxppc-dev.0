Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9j637X9zDqXD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:57:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 "cyrilbur\@gmail.com" <cyrilbur@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
In-Reply-To: <20160715071546.GA5290@simonLocalRHEL7.x64>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
 <1467898167.27157.47.camel@kernel.crashing.org>
 <577f7a45.568f6b0a.bd0eb.4aa8SMTPIN_ADDED_BROKEN@mx.google.com>
 <20160715071546.GA5290@simonLocalRHEL7.x64>
Date: Thu, 21 Jul 2016 20:57:29 +1000
Message-ID: <87h9bjtg12.fsf@@concordia.ellerman.id.au>
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

Simon Guo <wei.guo.simon@gmail.com> writes:

> Michael, Ben,
> On Fri, Jul 08, 2016 at 08:02:42PM +1000, Michael Ellerman wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>=20
>> > On Thu, 2016-07-07 at 23:21 +1000, Benjamin Herrenschmidt wrote:
>> >>=C2=A0
>> >> I think the right fix is that if a restore_sigcontext() has the MSR
>> >> bits set,
>> >> it should set the corresponding used_* flag.
>> >
>> > Something like this:
>> >
>> > (totally untested)
>>=20
>> Simon/Laurent, can you guys test this and let me know if it works for
>> your usecase.
>
> Sorry for the late reply. I tested Ben's patch and the fix works for the =
CRIU
> case mentioned before.

Thanks.

Can one of you send a properly formatted and signed-off patch.

cheers
