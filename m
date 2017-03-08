Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdF3D4YdSzDqY2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 11:37:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [RESEND PATCH] powerpc/pseries: move struct hcall_stats to c file
In-Reply-To: <1488879162-20596-1-git-send-email-me@tobin.cc>
References: <1488879162-20596-1-git-send-email-me@tobin.cc>
Date: Wed, 08 Mar 2017 11:37:08 +1100
Message-ID: <87lgsgk3ij.fsf@concordia.ellerman.id.au>
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

"Tobin C. Harding" <me@tobin.cc> writes:

> struct hcall_stats is only used in hvCall_inst.c.
>
> Move struct hcall_stats to hvCall_inst.c
>
> Resolves: #54
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>
> Is this correct, adding 'Resolves: #XX' when fixing
> github.com/linuxppc/linux issues?

Not in the change log (the part above ---). That gets committed to the
history, and we don't want to clutter that with github issue numbers.
The kernel history will probably outlive the github issues, at which
point the issue numbers become meaningless.

You can put Resolves: in this section (below ---), if you like. That is
just informational and doesn't get committed.

But I'm also happy to just close the github issues manually. When I do
that I make a link from the issue to the commit, but not the other way
around.

cheers
