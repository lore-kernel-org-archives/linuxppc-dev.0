Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwd0z5ZdhzF1T9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:29:39 +1100 (AEDT)
In-Reply-To: <20180306081432.3653-1-bharata@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [FIX] powerpc/pseries: Fix vector5 in ibm architecture vector
 table
Message-Id: <3zwd0z1C78z9shP@ozlabs.org>
Date: Wed,  7 Mar 2018 00:29:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-06 at 08:14:32 UTC, Bharata B Rao wrote:
> With ibm,dynamic-memory-v2 and ibm,drc-info coming around the
> same time, byte22 in vector5 of ibm architecture vector table
> got set twice separately. The end result is that guest kernel
> isn't advertising support for ibm,dynamic-memory-v2.
> 
> Fix this by removing the duplicate assignment of byte22.
> 
> Fixes: 02ef6dd8109b5 (powerpc: Enable support for ibm,drc-info devtree property)
> Fixes: c7a3275e0f9e4 (powerpc/pseries: Revert support for ibm,drc-info devtree property)
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b0c41b8b6e43120d7c35e4709508a3

cheers
