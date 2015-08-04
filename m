Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FACD1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 10:51:35 +1000 (AEST)
Message-ID: <1438649494.9418.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
 linux-kernel@vger.kernel.org
Date: Tue, 04 Aug 2015 10:51:34 +1000
In-Reply-To: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

On Fri, 2015-07-31 at 11:29 +0200, Laurent Dufour wrote:
> This patch fixes several endianness issues detected when running the HVSI
> driver in little endian mode.
> 
> These issues are raised in little endian mode because the data exchanged in
> memory between the kernel and the hypervisor has to be in big endian
> format.

Can you include the sparse output before and after?

cheers
