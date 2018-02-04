Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yF5BvTzF0Y6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yF1cw1z8t8G
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yD5TZTz9t2l
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:11 +1100 (AEDT)
Date: Sun, 4 Feb 2018 12:03:00 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 14/16] powerpc/powernv: Check device-tree
 for RFI flush settings
Message-ID: <20180204110300.GI7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-15-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-15-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:08PM +1100, Michael Ellerman wrote:
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> commit 6e032b350cd1fdb830f18f8320ef0e13b4e24094 upstream.
> 
> New device-tree properties are available which tell the hypervisor
> settings related to the RFI flush. Use them to determine the
> appropriate flush instruction to use, and whether the flush is
> required.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 50 ++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Also applied to 4.9.y
