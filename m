Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GHHH710dzF3Lt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 23:13:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Andy Whitcroft <apw@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
In-Reply-To: <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
Date: Thu, 20 Sep 2018 23:13:43 +1000
Message-ID: <87worgia60.fsf@concordia.ellerman.id.au>
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

Joe Perches <joe@perches.com> writes:

> On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
>> On the below patch, checkpatch reports
>> 
>> WARNING: struct kgdb_arch should normally be const
>> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
>> +struct kgdb_arch arch_kgdb_ops;
>> 
>> But when I add 'const', I get compilation failure
>
> So don't add const.
>
> checkpatch is stupid.  You are not.
>
> _Always_ take checkpatch bleats with very
> large grains of salt.
>
> Perhaps send a patch to remove kgbd_arch
> from scripts/const_structs.checkpatch as
> it seems not ever to be const.

I think it could/should be const though, it just requires updating all
arches.

cheers
