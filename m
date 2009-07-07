Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 886AAB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 18:14:59 +1000 (EST)
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3E1C4DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 18:14:58 +1000 (EST)
Date: Tue, 7 Jul 2009 03:20:12 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
Message-ID: <20090707082011.GA21670@lixom.net>
References: <6c9c0889feaceeea55bd2b6fef0c19e408425ef5.1246846125.git.michael@ellerman.id.au>
	<20090706135926.GA16205@lixom.net>
	<1246926753.4449.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246926753.4449.1.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2009 at 10:32:33AM +1000, Michael Ellerman wrote:

> I was also wondering, was this workaround ever required in a released
> chip - or was it just dev samples? If it's the latter, do we still need
> to carry it at all?

It's needed on all versions of hardware but for slightly different
reasons.

I had to research it when the discussion came up, since the first time
I used this workaround it was needed for a different erratum. But yes,
it is there in shipping products -- I was usually pretty careful not to
merge unneeded patches.


-Olof
