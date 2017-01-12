Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzqGp13TBzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 02:21:21 +1100 (AEDT)
Message-ID: <1484234447.2492.34.camel@kernel.crashing.org>
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Segher Boessenkool
 <segher@kernel.crashing.org>
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 12 Jan 2017 09:20:47 -0600
In-Reply-To: <7604032b-c9ae-e3ce-fcd5-d9e555559f52@c-s.fr>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
 <20170111225440.GQ28613@gate.crashing.org>
 <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
 <7604032b-c9ae-e3ce-fcd5-d9e555559f52@c-s.fr>
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

On Thu, 2017-01-12 at 15:42 +0100, Christophe LEROY wrote:
> The 4.6.3 uses __stack_chk_guard, while the 4.4.4 and 4.8.3 use
> -28680(r2)
> 
> Is it dependent on the way GCC is built ? Then do we have a way to
> know, 
> when we compile, which method GCC will use ?
> 
> See details below for each of the 3 GCC versions.

I think it depends if you built it along with glibc (so it can produce
userspace binaries) or not.

Cheers,
Ben.
