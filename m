Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttvhS22bgzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 02:23:03 +1100 (AEDT)
Date: Wed, 4 Jan 2017 07:22:58 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
In-Reply-To: <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
Message-ID: <alpine.DEB.2.20.99.1701040721220.31470@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Jan 2017, Christophe LEROY wrote:
> Looking a bit over internet, some people have reported having encountered that
> issue due to old object files not properly cleaned.
> Have you tried a 'make clean' or 'distclean' ?

I'm compiling with O=$DIR and I've deleted the entire $DIR before 
compilation. So no, old object files is not the issue here.

Christian.
-- 
BOFH excuse #105:

UPS interrupted the server's power
