Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B1D51A06A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 09:38:18 +1100 (AEDT)
Message-ID: <1417041497.12952.2.camel@concordia>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 27 Nov 2014 09:38:17 +1100
In-Reply-To: <1417036288-22079-1-git-send-email-anton@samba.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 08:11 +1100, Anton Blanchard wrote:
> I used some 64 bit instructions when adding the 32 bit getcpu VDSO
> function. Fix it.

Ouch. The symptom is a SIGILL I presume?

Could we catch this by forcing -m32 in the CFLAGS for vdso32 ?

cheers
