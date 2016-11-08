Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCj2C18PxzDvJD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 19:21:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 agraf@suse.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH V3 1/2] powerpc: Define new ISA v3.00 logical PVR value
 and PCR register value
In-Reply-To: <1477975263-29045-2-git-send-email-sjitindarsingh@gmail.com>
References: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
 <1477975263-29045-2-git-send-email-sjitindarsingh@gmail.com>
Date: Tue, 08 Nov 2016 19:21:21 +1100
Message-ID: <87y40ujsam.fsf@concordia.ellerman.id.au>
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

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition for
> this.
>
> Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the processor
> compatibility register (PCR). Also define a dummy ISA 3.00 compatibility
> mode PCR_ARCH_300 to be used in the next patch to help with determining the
> PCR value.

What's "dummy" about the PCR value?

AFAICS that value is reserved in the ISA.

Are we assuming/hoping that ISA 4.0 will use 0x10 to mean ISA 3.0 ?

cheers
