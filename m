Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryMz86PNvzDqhD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:47:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc
Cc: benh@kernel.crashing.org, paulus@samba.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
In-Reply-To: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 10:47:13 +1000
Message-ID: <87fuqy1r3i.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> This is a very minor/trivial fix for the output of PCI address on EEH logs.
> The PCI address on "OF node" field currently is using ":" as a separator
> for the function, but the usual separator is ".". This patch changes the
> separator for dot, so the PCI address is printed as usual.
>
> No functional changes were introduced.

What consumes the log? Can it cope with us changing the formatting?

cheers
