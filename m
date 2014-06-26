Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286A31A000D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 18:30:56 +1000 (EST)
Message-ID: <1403771455.18572.8.camel@concordia>
Subject: Re: [PATCH v2 2/2] powerpc: bpf: Fix the broken LD_VLAN_TAG_PRESENT
 test
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu, 26 Jun 2014 18:30:55 +1000
In-Reply-To: <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
References: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
 <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 21:34 +0400, Denis Kirjanov wrote:
> We have to return the boolean here if the tag presents
> or not, not just ANDing the TCI with the mask which results to:
> 
> [  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
> [  709.412245] ret 4096 != 1
> [  709.412332] ret 4096 != 1
> [  709.412333] FAIL (2 times)

Hi Denis,

Is this the same version of test_bpf that is in Linus' tree?

I don't see any fails with that version, am I missing something?

  [  187.690640] test_bpf: #18 LD_VLAN_TAG_PRESENT 46 50 PASS

cheers
