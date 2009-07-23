Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 402FDB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:49:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78DB7DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:49:13 +1000 (EST)
Message-Id: <2B7AAE33-C376-4972-B8C7-6B83F5A88033@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090723055956.91CDBDDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 10/20] powerpc: Clean ifdef usage in copy_thread()
Date: Thu, 23 Jul 2009 09:49:01 -0500
References: <20090723055956.91CDBDDD1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 12:59 AM, Benjamin Herrenschmidt wrote:

> Currently, a single ifdef covers SLB related bits and more generic  
> ppc64
> related bits, split this in two separate ifdef's since 64-bit BookE  
> will
> need one but not the other.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/kernel/process.c |    2 ++
> 1 file changed, 2 insertions(+)


Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
