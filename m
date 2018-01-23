Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfGb1tbJzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 17:56:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yang Li <pku.leo@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Anyone working on the KPTI support for powerpc?
In-Reply-To: <CADRPPNRVb_CGBesSD6zQcPmrATxqSHhSmywAEfTT7jqpioNaGg@mail.gmail.com>
References: <CADRPPNRVb_CGBesSD6zQcPmrATxqSHhSmywAEfTT7jqpioNaGg@mail.gmail.com>
Date: Tue, 23 Jan 2018 17:56:22 +1100
Message-ID: <87607toyg9.fsf@concordia.ellerman.id.au>
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

Yang Li <pku.leo@gmail.com> writes:

> I assume some of the powerpc platforms would be impacted by the newly
> announced meltdown/spetre vulnerabilities.  It will be good if we have
> an aligned implementation of the KPTI.

Hi Leo,

We aren't working on KPTI at the moment, but we did recently merge some
related changes:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bb821193b6e8b9cc40714f700da27b4688cbc22

cheers
