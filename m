Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0011.hostedemail.com
 [216.40.44.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G1rp5xH0zF0dq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 13:08:25 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 775CB180301B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 03:02:19 +0000 (UTC)
Message-ID: <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Andy Whitcroft
 <apw@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Sep 2018 20:02:05 -0700
In-Reply-To: <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
> On the below patch, checkpatch reports
> 
> WARNING: struct kgdb_arch should normally be const
> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
> +struct kgdb_arch arch_kgdb_ops;
> 
> But when I add 'const', I get compilation failure

So don't add const.

checkpatch is stupid.  You are not.

_Always_ take checkpatch bleats with very
large grains of salt.

Perhaps send a patch to remove kgbd_arch
from scripts/const_structs.checkpatch as
it seems not ever to be const.
