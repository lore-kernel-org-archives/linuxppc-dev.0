Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHQ2yFKzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:58 +1000 (AEST)
In-Reply-To: <20170419073927.29224-2-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, Russell Currey <ruscur@russell.cc>
Subject: Re: [v3,
 2/2] powerpc/eeh: Clean up and document event handling functions
Message-Id: <3wJCHQ2J9dz9s2G@ozlabs.org>
Date: Thu,  4 May 2017 08:18:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 07:39:27 UTC, Russell Currey wrote:
> Remove unnecessary tags in eeh_handle_normal_event(), and add function
> comments for eeh_handle_normal_event() and eeh_handle_special_event().
> 
> The only functional difference is that in the case of a PE reaching the
> maximum number of failures, rather than one message telling you of this
> and suggesting you reseat the device, there are two separate messages.
> 
> Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c0b64978f09195e00d6649ca0ad024

cheers
