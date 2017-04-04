Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy7Mj71C7zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 22:20:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 02/12] powerpc: Sync opal-api.h
In-Reply-To: <20170320064914.4437-2-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
 <20170320064914.4437-2-benh@kernel.crashing.org>
Date: Tue, 04 Apr 2017 22:20:00 +1000
Message-ID: <871st8uzyn.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

...

Give me some change log !

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/opal-api.h            | 302 ++++++++++++++++++++-----

It looks like you've just copied it over in its entirety, including lots
of unused cruft.

Please just give me the XIVE bits you need.

cheers
