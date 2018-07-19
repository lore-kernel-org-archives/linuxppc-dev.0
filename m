Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WXjB0YyhzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 22:03:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Mathieu
 Malaterre <malat@debian.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
In-Reply-To: <20180718162116.GA24748@kermit-br-ibm-com>
References: <20180712171904.18971-1-muriloo@linux.ibm.com>
 <87a7qoq3z2.fsf@concordia.ellerman.id.au>
 <20180718162116.GA24748@kermit-br-ibm-com>
Date: Thu, 19 Jul 2018 22:03:19 +1000
Message-ID: <878t67cu0o.fsf@concordia.ellerman.id.au>
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

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Wed, Jul 18, 2018 at 07:37:37PM +1000, Michael Ellerman wrote:
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>> > This property was added in 2004 by
>> >
>> >     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
>> >
>> > and the only use of it, which was already inside `#if 0`, was removed a month
>> > later by
>> >
>> >     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
>> >
>> > Fixes: https://github.com/linuxppc/linux/issues/125
>> 
>> That is going to confuse some scripts that are expecting that to be a
>> "Fixes: <some commit>" tag :)
>> 
>> The proper tag to use there would be "Link:".
>> 
>> But, I'd prefer we didn't add github issue links to the history, as I'm
>> not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
>> conspiracy person but just because it's a repo I set up and manage and
>> there's no long term plan for it necessarily.
>> 
>> > ---
>> >  arch/powerpc/kernel/prom_init.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> 
>> Including the link here would be ideal, as it means it doesn't end up in
>> the commit history, but it does end up in the mail archive. So if we
>> ever really need to find it, it should be there.
>> 
>> cheers
>
> Hi, Michael.
>
> Thanks for reviewing it.  I've sent v2 with your suggestions:
>
>     https://lkml.kernel.org/r/20180718161544.12134-1-muriloo@linux.ibm.com

Thanks.

I had actually already applied the first version, but I didn't say that
in my email did I :}

So I've rebased and applied your v2, thanks.

cheers
