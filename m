Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB01F1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 15:38:46 +1100 (AEDT)
In-Reply-To: <1412920428-29263-1-git-send-email-bobby.prani@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Fabian Frederick <fabf@skynet.be>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Wire up sys_bpf() syscall
Message-Id: <20141021043846.8E5D4140092@ozlabs.org>
Date: Tue, 21 Oct 2014 15:38:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 05:53:45 UTC, Pranith Kumar wrote:
> This patch wires up the new syscall sys_bpf() on powerpc.

Is there a test suite we can run to verify it works?

cheers
