Return-Path: <srs0=vfdj=3m=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy9Jh4lbwzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 23:47:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vy9Jh3byYz8syf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 23:47:32 +1000 (AEST)
Message-ID: <1491313645.4166.47.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/12] powerpc: Sync opal-api.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
Date: Tue, 04 Apr 2017 23:47:25 +1000
In-Reply-To: <871st8uzyn.fsf@concordia.ellerman.id.au>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
 <20170320064914.4437-2-benh@kernel.crashing.org>
 <871st8uzyn.fsf@concordia.ellerman.id.au>
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

On Tue, 2017-04-04 at 22:20 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> ...
> 
> Give me some change log !

Well, the subject says it all :-) Sync the API with the latest OPAL :-)

> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  arch/powerpc/include/asm/opal-api.h            | 302
> > ++++++++++++++++++++-----
> 
> It looks like you've just copied it over in its entirety, including
> lots of unused cruft.
> 
> Please just give me the XIVE bits you need.

Why ? It's a lot easier in the long run to have the file actually in
sync between the two projects no ?

Cheers,
Ben.
