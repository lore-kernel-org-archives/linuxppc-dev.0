Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s775H4cBpzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 16:37:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] powerpc/mpic: use of_property_read_bool
In-Reply-To: <1470387411-15879-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
 <1470387411-15879-10-git-send-email-Julia.Lawall@lip6.fr>
Date: Mon, 08 Aug 2016 16:37:52 +1000
Message-ID: <87y447sr3z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall <Julia.Lawall@lip6.fr> writes:

> Use of_property_read_bool to check for the existence of a property.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression e1,e2;
> statement S2,S1;
> @@
> -       if (of_get_property(e1,e2,NULL))
> +       if (of_property_read_bool(e1,e2))
>         S1 else S2
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  arch/powerpc/sysdev/mpic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
