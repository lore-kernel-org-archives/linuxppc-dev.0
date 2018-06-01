Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86Y3Cn2zF0WH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:55:01 +1000 (AEST)
In-Reply-To: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/modules: remove unused mod_arch_specific.toc field
Message-Id: <40y86X6K4mz9s4Y@ozlabs.org>
Date: Sat,  2 Jun 2018 01:55:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-25 at 03:48:34 UTC, Josh Poimboeuf wrote:
> The toc field in the mod_arch_specific struct isn't actually used
> anywhere, so remove it.
> 
> Also the ftrace-specific fields are now common between 32-bit and
> 64-bit, so simplify the struct definition a bit by moving them out of
> the __powerpc64__ #ifdef.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8ce621e1d946b1d1d7717337ab8dc3

cheers
