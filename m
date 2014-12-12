Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 901711A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 16:22:31 +1100 (AEDT)
Message-ID: <1418361751.1465.3.camel@ellerman.id.au>
Subject: Re: [PATCH 2 0/4] powerpc: don't mess with SMT at boot time
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Fri, 12 Dec 2014 16:22:31 +1100
In-Reply-To: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-05 at 16:13 +0100, Greg Kurz wrote:
> As requested by mpe, this series now covers both the smt-enabled
> kernel parameter and the ibm,smt-enabled property. The cleanup was
> split into 3 separate patches to ease review, but I guess they
> could be folded into a single patch as well.

Sorry to send you down the garden path Greg. It would have been a nice
cleanup, but seems the FSL folks still see value in smt-enabled.

So can you rework it to just ignore smt-enabled on powernv.

That should be as simple as implementing a powernv_cpu_bootable() that always
returns true.

cheers
