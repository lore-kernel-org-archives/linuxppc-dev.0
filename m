Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3hHR3GgQzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:20:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Rashmica Gupta <rashmicy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Move page table dump into powerpc subdirectory
In-Reply-To: <20170413124148.EB6C76E664@localhost.localdomain>
References: <20170413124148.EB6C76E664@localhost.localdomain>
Date: Thu, 13 Apr 2017 23:20:34 +1000
Message-ID: <87fuhc8mvx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Page table dump is a powerpc specific thing, so it should
> appear in powerpc/ subdirectory of debugfs

It's not powerpc specific. x86, arm, arm64 and s390 all have it.

But, I notice we somehow got the name wrong :}

All the other arches call it "kernel_page_tables".

> -	debugfs_file =3D debugfs_create_file("kernel_pagetables", 0400, NULL,
> -			NULL, &ptdump_fops);

=C2=AF\_(=E3=83=84)_/=C2=AF


So we probably should rename it to match the other arches. I would take
a patch for that.

cheers
