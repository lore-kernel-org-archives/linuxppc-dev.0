Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tygwS1H4RzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 05:46:29 +1100 (AEDT)
Date: Tue, 10 Jan 2017 10:46:23 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
cc: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
In-Reply-To: <1484022722.21117.8.camel@au1.ibm.com>
Message-ID: <alpine.DEB.2.20.999.1701101041480.5450@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <1484022722.21117.8.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 9 Jan 2017, Benjamin Herrenschmidt wrote:
> On Mon, 2017-01-09 at 18:11 -0800, Christian Kujau wrote:
> > So, with -fno-stack-protector my GCC 4.9.2 compiles with 
> > CC_STACKPROTECTOR_STRONG=y but panics during boot:
> 
> How can it make any sense to have -fno-stack-protector and
> CC_STACKPROTECTOR_STRONG=y at the same time ?

I've set -fno-stack-protector only for bootx_init.c, as laid out in the 
diff I posted. This way the kernel at least compiled.

Thanks,
Christian.
-- 
BOFH excuse #423:

It's not RFC-822 compliant.
