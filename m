Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id E1D6F67B81
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 22:43:23 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060919222351.d27a1a06.sfr@canb.auug.org.au> 
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au> 
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] convert string i/o operations to C 
Date: Tue, 19 Sep 2006 13:42:58 +0100
Message-ID: <28673.1158669778@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> +{
> +	asm volatile("sync");
> +	if (ns <= 0)
> +		return;

What is "ns" meant to do?  It seems to degrade the _insb() op to just a sync,
but is that correct?

David
