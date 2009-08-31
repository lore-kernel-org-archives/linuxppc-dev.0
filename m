Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A5642B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 04:47:26 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 42A78DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 04:47:24 +1000 (EST)
Date: Mon, 31 Aug 2009 22:47:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Tabi Timur-B04825 <timur@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Message-ID: <20090831184722.GA12244@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193715.GA17519@oksana.dev.rtsoft.ru>
	<5610599F537DD74A8D1F5CC946A7507301DCCC8A@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5610599F537DD74A8D1F5CC946A7507301DCCC8A@az33exm25.fsl.freescale.net>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 30, 2009 at 05:36:28PM -0700, Tabi Timur-B04825 wrote:
> Is the need to reinitialize the QE after resume something that
> is unique to the 8569, or would it apply to the 8360 and 8323 also?

8569 is unique in this regard, though I'm not sure if that's by design
or because of some errata.

Just as 8569 is unique that it needs QE microcode loaded externally
since the CPU doesn't have any ROM where the microcode can be stored.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
