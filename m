Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVC4r1RJDzDsN5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 17:43:38 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
Date: Thu, 08 Sep 2016 09:44:17 +0200
Message-ID: <6411576.kd9HS3NQth@wuerfel>
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, September 6, 2016 3:32:39 PM CEST Daniel Axtens wrote:
> Sparse checking revealed that it is no longer used.
> There is an EXPORT_SYMBOL_GPL, but there's no header that
> provides a prototype, so nothing should be using it anyway.
> 
> Remove it.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Good catch!

I'm currently experimenting with a patch that adds -Wmissing-declaration to
the normal kernel CFLAGS for everyone, and fixing up the warnings I get with
that on ARM.

Are you looking at all the powerpc specific code? If we can catch all the
existing warnings for some of the major architectures, we can hopefully
enable this in the mainline kernel at some point so we don't need sparse
for it any more.

	Arnd
