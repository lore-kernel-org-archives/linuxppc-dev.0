Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxpZM0ygFzF1kD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 22:44:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 21/21] powerpc: Add missing prototypes in setup_32.c
In-Reply-To: <20180225172236.29650-22-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-22-malat@debian.org>
Date: Thu, 08 Mar 2018 22:44:06 +1100
Message-ID: <876066eqrd.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:

> This commit add the prototypes for the following function:
>
> - early_init
> - machine_init

I'd rather these were in asm-prototypes.h, it's the header for functions
called from asm. I made that change.

> - ppc_setup_l2cr
> - ppc_setup_l3cr
> - ppc_init

These three can just be static. So I did that.

cheers
