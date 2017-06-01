Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdpBz522yzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 23:31:07 +1000 (AEST)
In-Reply-To: <b284d6be-ff37-4e5c-7357-446b4e1ea8ad@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, paulus@samba.org,
 nfont@linux.vnet.ibm.com, sahilmehta17@gmail.com, jallen@linux.vnet.ibm.com,
 mwb@linux.vnet.ibm.com, alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/hotplug-mem: Fix aa_index match bug for hotplug
Message-Id: <3wdpBz4LPQz9s78@ozlabs.org>
Date: Thu,  1 Jun 2017 23:31:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-22 at 20:44:37 UTC, Michael Bringmann wrote:
> When adding or removing memory, the aa_index (affinity value) for the
> memblock must also be converted to match the endianness of the rest
> of the 'ibm,dynamic-memory' property.  Otherwise, subsequent retrieval
> of the attribute will likely lead to non-existent nodes, followed by
> using the default node in the code inappropriately.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dc421b200f91930c9c6a9586810ff8

cheers
