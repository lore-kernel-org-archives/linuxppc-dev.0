Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JXTm60snzF13h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 15:15:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Lamparter <equinox@diac24.net>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <swood@redhat.com>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
In-Reply-To: <20180920224856.GJ487685@eidolon.nox.tf>
References: <20180920224856.GJ487685@eidolon.nox.tf>
Date: Mon, 24 Sep 2018 15:15:35 +1000
Message-ID: <87y3br5vd4.fsf@concordia.ellerman.id.au>
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

David Lamparter <equinox@diac24.net> writes:

> This is a *partial* revert of "powerpc/85xx: Load all early TLB entries
> at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)
>
> My dusty old P4080DS just completely fails to boot (no output at all)
> without this revert.  I have no clue what's going on here, I just
> bisected it down and since it looks like an optimization to me I just
> reverted it - and voil=C3=A1, the P4080 boots again.
>
> Cc: Scott Wood <swood@redhat.com>
> Signed-off-by: David Lamparter <equinox@diac24.net>
> ---
> I'm not subscribed to linuxppc-dev, please keep me in Cc:.  Also I
> contribute to the kernel only very rarely and have no clue how to find
> out when the appropriate time in the merge window is to submit things to
> linuxppc-dev... my apologies.

Don't worry about the timing of sending patches.

Your patch will be tracked in patchwork, so if it's not a good time
we'll just ignore it until it is a good time :)

cheers
