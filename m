Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E424C1A06A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 17:36:17 +1100 (AEDT)
Message-ID: <1444890977.5970.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/mpc5xxx: Avoid dereferencing potentially
 freed memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Thu, 15 Oct 2015 17:36:17 +1100
In-Reply-To: <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <20151014040011.8AB1514110A@ozlabs.org>
 <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
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

On Thu, 2015-10-15 at 07:56 +0200, Christophe JAILLET wrote:
> Use 'of_property_read_u32()' instead of 'of_get_property()'+pointer
> dereference in order to avoid access to potentially freed memory.
> 
> Use 'of_get_next_parent()' to simplify the while() loop and avoid the
> need of a temp variable.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Use of_property_read_u32 instead of of_get_property+pointer dereference
> *** Untested ***

Thanks.

Can someone with an mpc5xxx test this?

cheers
