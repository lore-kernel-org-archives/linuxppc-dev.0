Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F359667B59
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 21:56:11 +1000 (EST)
Date: Wed, 27 Sep 2006 15:56:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
In-Reply-To: <17690.7311.157219.154172@cargo.ozlabs.ibm.com>
References: <45128378.7090508@freescale.com>
	<17690.7311.157219.154172@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2006 16:39:11 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Li Yang writes:
> 
> > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > +#define BCSR_SIZE		((uint)(32 * 1024))
> 
> This sort of thing should really be in the device tree.
> 
Just a suggestion, but for the similar aim in pq2 I have those stuff in memory node :

+memory {
+               device_type = "memory";
+               linux,phandle = <300>;
+               reg = <00000000 4000000 f4500000 00000020>;
+       };
the second pair is about bcsr and its size.

Just in case this may help (and wondering if I'm not violating something :) ) 
-- 
Sincerely, 
Vitaly
