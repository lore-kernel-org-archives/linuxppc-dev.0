Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R4g44tkszF35k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:46:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
 Daniel Klamt <eleon@ele0n.de>, Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep(x) with
 msleep(OPAL_BUSY_DELAY_MS)
In-Reply-To: <1531346584-9157-1-git-send-email-eleon@ele0n.de>
References: <878t6hami4.fsf@concordia.ellerman.id.au>
 <1531346584-9157-1-git-send-email-eleon@ele0n.de>
Date: Thu, 12 Jul 2018 15:46:06 +1000
Message-ID: <87bmbd80rl.fsf@concordia.ellerman.id.au>
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

Daniel Klamt <eleon@ele0n.de> writes:

> Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
> to diocument these sleep is to wait for opal.
>
> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>

Thanks.

Your change log should be in the imperative mood, see:

  https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?id=HEAD#n133


In this case that just means saying "Replace" rather than "Replaced".

Also the prefix should be "powerpc/xive". You can guess that by doing:

  $ git log --oneline arch/powerpc/sysdev/xive/native.c

And notice that the majority of commits use that prefix.


I've fixed both of those things up for you.

cheers
