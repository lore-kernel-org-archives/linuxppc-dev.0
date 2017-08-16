Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJrn5YXbzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:11:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: rpjday@crashcourse.ca, linuxppc-dev@lists.ozlabs.org
Subject: Re: should "linux-phandle" be "linux,phandle"?
In-Reply-To: <20170815085305.Horde.UHGi_X5RJB80EmE3IdmqXz3@crashcourse.ca>
References: <20170815085305.Horde.UHGi_X5RJB80EmE3IdmqXz3@crashcourse.ca>
Date: Wed, 16 Aug 2017 16:11:37 +1000
Message-ID: <878tikt52e.fsf@concordia.ellerman.id.au>
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

rpjday@crashcourse.ca writes:

>    pedantic nitpickery but, in arch/powerpc/kernel/prom_init.c, line 2426,
> should that diagnostic message print "<linux,phandle>" and not  
> "<linux-phandle>"?

Yeah I guess.

AFAICS it can't happen though, we created the "linux,phandle" string
just prior, around line 2488.

So it could just be:

		soff = dt_find_string("linux,phandle");
		if (soff == 0)
			prom_printf("WARNING: Wat?!\n");
		else
			...

cheers
