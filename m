Return-Path: <corbet@lwn.net>
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Q0Wh2cmszF1yf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 06:35:43 +1000 (AEST)
Date: Mon, 16 Apr 2018 14:35:38 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin
 <aryabinin@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf
 Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
Message-ID: <20180416143538.40a40457@lwn.net>
In-Reply-To: <20180415173655.GB31176@rapoport-lnx>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180329154607.3d8bda75@lwn.net>
 <20180401063857.GA3357@rapoport-lnx>
 <20180413135551.0e6d1b12@lwn.net>
 <20180415173655.GB31176@rapoport-lnx>
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

On Sun, 15 Apr 2018 20:36:56 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> I didn't mean we should keep it as unorganized jumble of stuff and I agree
> that splitting the documentation by audience is better because developers
> are already know how to find it :)
> 
> I just thought that putting the doc into the place should not be done
> immediately after mechanical ReST conversion but rather after improving the
> contents.

OK, this is fine.  I'll go ahead and apply the set, but then I'll be
watching to see that the other improvements come :)

In applying the set, there was a significant set of conflicts with
vm/hmm.rst; hopefully I've sorted those out properly.

Thanks,

jon
