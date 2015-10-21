Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1325D1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:44 +1100 (AEDT)
In-Reply-To: <1445031525-20086-1-git-send-email-christophe.jaillet@wanadoo.fr>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/prom: Avoid reference to potentially freed memory
Message-Id: <20151021114143.EE9111409F8@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-16-10 at 21:38:45 UTC, Christophe Jaillet wrote:
> of_get_property() is used inside the loop, but then the reference to the
> node is dropped before dereferencing the prop pointer, which could by then
> point to junk if the node has been freed.
> 
> Instead use of_property_read_u32() to actually read the property
> value before dropping the reference.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1856f50c66dff0afb4a6a3e2

cheers
