Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 889921A0929
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:07:06 +1000 (EST)
Message-ID: <1410937625.27681.10.camel@concordia>
Subject: Re: [2/5] pseries: Export drc_[acquire|release]_drc() routines
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 17:07:05 +1000
In-Reply-To: <54174C5F.4090604@linux.vnet.ibm.com>
References: <54174C5F.4090604@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-09-15 at 15:30 -0500, Nathan Fontenot wrote:
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 361add6..b94516b 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -59,6 +59,8 @@ extern void dlpar_free_cc_property(struct property *);
>  extern struct device_node *dlpar_configure_connector(u32, struct device_node *);
>  extern int dlpar_attach_node(struct device_node *);
>  extern int dlpar_detach_node(struct device_node *);
> +extern int dlpar_acquire_drc(u32);
> +extern int dlpar_release_drc(u32);

Please name the parameters.

And don't bother with extern.

cheers
