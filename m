Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xL15XpzF2MD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:26 +1100 (AEDT)
In-Reply-To: <d3d01073da02a5eb844cc8998fdac602b8121b62.1521427331.git.sam.bobroff@au1.ibm.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,1/9] powerpc/eeh: Remove eeh_handle_event()
Message-Id: <40B8xK5LGpz9s12@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-19 at 02:46:20 UTC, Sam Bobroff wrote:
> The function eeh_handle_event(pe) does nothing other than switching
> between calling eeh_handle_normal_event(pe) and
> eeh_handle_special_event(). However it is only called in two places,
> one where pe can't be NULL and the other where it must be NULL (see
> eeh_event_handler()) so it does nothing but obscure the flow of
> control.
> 
> So, remove it.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/68701780712f7ddb2fa81032aa1b4a

cheers
