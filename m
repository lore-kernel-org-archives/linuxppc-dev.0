Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C3314B7DCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 04:47:34 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 5F97BDDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 04:47:34 +1000 (EST)
Date: Mon, 31 Aug 2009 22:47:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Tabi Timur-B04825 <timur@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume support
Message-ID: <20090831184733.GA12997@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
	<5610599F537DD74A8D1F5CC946A7507301DCCC8B@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5610599F537DD74A8D1F5CC946A7507301DCCC8B@az33exm25.fsl.freescale.net>
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

On Sun, Aug 30, 2009 at 05:38:05PM -0700, Tabi Timur-B04825 wrote:
> 
> What about the 8610?

Yes, it is supported. The bindings decribe that 8641d should
be used as a base match, so 8610-pmc is 8641d-compatible.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
