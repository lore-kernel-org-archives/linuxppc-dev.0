Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 4A429B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 11:37:26 +1000 (EST)
Received: by vws20 with SMTP id 20so5745495vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 18:37:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1282281295.22370.400.camel@pasglop>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.400.camel@pasglop>
Date: Mon, 23 Aug 2010 20:37:23 -0500
Message-ID: <AANLkTinsTMxmhScg2nfr=4hASqPbsqAOSgnG-V21N-P+@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Make rwsem use "long" type
From: Timur Tabi <timur@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 20, 2010 at 12:14 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> =A0static inline int rwsem_is_locked(struct rw_semaphore *sem)
> =A0{
> - =A0 =A0 =A0 return (sem->count !=3D 0);
> + =A0 =A0 =A0 return sem->count !=3D 0;
> =A0}

Does this change make the code do anything different?

--=20
Timur Tabi
Linux kernel developer at Freescale
