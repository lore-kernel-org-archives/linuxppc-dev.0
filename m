Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5g1461bzDqmq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:39:09 +1000 (AEST)
In-Reply-To: <20160526083813.0f96a454@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, acsawdey@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: Remove assembly versions of strcpy, strcat,
 strlen and strcmp
Message-Id: <3rV5g13G0jz9t1T@ozlabs.org>
Date: Wed, 15 Jun 2016 22:39:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-25-05 at 22:38:13 UTC, Unknown sender due to SPF wrote:
> A number of our assembly implementations of string functions do not
> align their hot loops. I was going to align them manually, but I
> realised that they are are almost instruction for instruction
> identical to what gcc produces, with the advantage that gcc does
> align them.
> 
> In light of that, let's just remove the assembly versions.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3ece16632b64120df2ef566ce3

cheers
