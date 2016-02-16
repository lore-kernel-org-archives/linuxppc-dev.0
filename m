Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 177711A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 14:18:25 +1100 (AEDT)
In-Reply-To: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC,
 kernel] powerpc/ioda: Set "read" permission when "write" is set
Message-Id: <20160216031824.E5C8E140761@ozlabs.org>
Date: Tue, 16 Feb 2016 14:18:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-01 at 04:40:20 UTC, Alexey Kardashevskiy wrote:
> Quite often drivers set only "write" permission assuming that this
> includes "read" permission as well and this works on plenty platforms.
> However IODA2 is strict about this and produces an EEH when "read"
> permission is not and reading happens.
> 
> This adds a workaround in IODA code to always add the "read" bit when
> the "write" bit is set.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>

Are you planning on sending a non-RFC version of this?

If so is it an urgent fix I should send upstream now? And if so should it
also be CC'ed to stable?

cheers
