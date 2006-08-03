Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BB71967B6E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 09:25:57 +1000 (EST)
Date: Fri, 4 Aug 2006 09:25:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-Id: <20060804092552.41f00701.sfr@canb.auug.org.au>
In-Reply-To: <20060803174058.GA3179@w-mikek2.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
	<20060803135717.754bd37f.sfr@canb.auug.org.au>
	<20060803040506.GB3484@monkey.ibm.com>
	<20060803174058.GA3179@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mike,

On Thu, 3 Aug 2006 10:40:58 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> What is the preferred method to 'leave it blank'?
> 
> #define HCALL_INST_PRECALL	/* nop */
> #define HCALL_INST_PRECALL	;
> something else?

I would have thought that

#define HCALL_INST_PRECALL

would work.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
