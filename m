Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqCq75NjzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:32:07 +1000 (AEST)
Message-ID: <1501810308.2664.59.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host
 proc tbl base update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 04 Aug 2017 11:31:48 +1000
In-Reply-To: <1501808533.5037.1.camel@gmail.com>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
 <87h8xpqi28.fsf@concordia.ellerman.id.au>
 <1501745720.2664.38.camel@kernel.crashing.org>
 <1501808533.5037.1.camel@gmail.com>
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

On Fri, 2017-08-04 at 11:02 +1000, Suraj Jitindar Singh wrote:
> 
> I guess there's the possibility of:
> [x] randomly crash
> 
> This is required to run a powernv kernel as a guest because we need to
> know when it's updated its process table location.

You mean in qemu full emu ? powernv kernels don't run as guest do they
?

Cheers,
Ben.
