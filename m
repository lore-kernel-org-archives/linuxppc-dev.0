Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxrD68N2zF0Vy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:36 +1100 (AEDT)
In-Reply-To: <1516326648-22775-4-git-send-email-linuxram@us.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, ebiederm@xmission.com,
 linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mhocko@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [v10,03/27] powerpc: initial pkey plumbing
Message-Id: <3zPxrB60pxz9sNx@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-19 at 01:50:24 UTC, Ram Pai wrote:
> Basic  plumbing  to   initialize  the   pkey  system.
> Nothing is enabled yet. A later patch will enable it
> once all the infrastructure is in place.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Patches 3-27 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/92e3da3cf193fd27996909956c12a2

cheers
