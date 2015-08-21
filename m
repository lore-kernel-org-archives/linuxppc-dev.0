Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4F711A005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 17:43:34 +1000 (AEST)
In-Reply-To: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: powerpc/hvsi: Fix endianness issues in the HVSI driver
Message-Id: <20150821074334.BA9D61402A9@ozlabs.org>
Date: Fri, 21 Aug 2015 17:43:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-31-07 at 09:29:50 UTC, Laurent Dufour wrote:
> This patch fixes several endianness issues detected when running the HVSI
> driver in little endian mode.
> 
> These issues are raised in little endian mode because the data exchanged in
> memory between the kernel and the hypervisor has to be in big endian
> format.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Jiri Slaby <jslaby@suse.cz>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/480798044eb268a31f6b

cheers
