Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CE4C1A081F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 13:15:28 +1100 (AEDT)
Message-ID: <1445048104.24309.49.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/3] mm/powerpc: enabling memory soft dirty tracking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org, criu@openvz.org
Date: Sat, 17 Oct 2015 07:45:04 +0530
In-Reply-To: <20151016141129.8b014c6d882c475fafe577a9@linux-foundation.org>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
 <20151016141129.8b014c6d882c475fafe577a9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-16 at 14:11 -0700, Andrew Morton wrote:
> I grabbed these patches, but they're more a ppc thing than a core
> kernel thing.  I can merge them into 4.3 with suitable acks or drop
> them if they turn up in the powerpc tree.  Or something else?

I'm happy for you to keep the generic ones but the powerpc one at the
end should be reviewed by Aneesh at least.

Cheers,
Ben.
