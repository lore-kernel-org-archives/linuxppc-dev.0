Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjqdG3NRzzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:49:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: de-deuplicate OPAL call wrappers
In-Reply-To: <1477874075-23178-1-git-send-email-oohall@gmail.com>
References: <1477874075-23178-1-git-send-email-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:49:05 +1100
Message-ID: <87shmekbf2.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> Currently the code to perform an OPAL call is duplicated between the
> normal path and path taken when tracepoints are enabled. There's no
> real need for this and combining them makes opal_tracepoint_entry
> considerably easier to understand.

Sorry I missed this when you sent it.

I don't think it applies any more, but if you rebased it I'd merge it.

cheers
