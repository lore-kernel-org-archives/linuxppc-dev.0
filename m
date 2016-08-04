Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4mM14dxPzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 20:26:37 +1000 (AEST)
Date: Thu, 4 Aug 2016 20:26:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: crc32c-vpmsum - Convert to CPU feature based
 module autoloading
Message-ID: <20160804202601.12aa879e@kryten>
In-Reply-To: <87lh0dexp3.fsf@concordia.ellerman.id.au>
References: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
 <87lh0dexp3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> Is VEC_CRYPTO the right feature?
> 
> That's new power8 crypto stuff.

The vpmsum* instructions are part of the same pipeline as the vcipher*
instructions, introduced in POWER8.

> I thought this only used VMX? (but I haven't looked closely)

Yes, vcipher* and vpmsum* are VMX instructions.

Anton
