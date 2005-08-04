Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5EADB67E68
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2005 15:18:32 +1000 (EST)
Date: Wed, 3 Aug 2005 22:17:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Message-Id: <20050803221715.43192b22.akpm@osdl.org>
In-Reply-To: <20050802095509.GA32585@lst.de>
References: <20050802095509.GA32585@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix gcc4 warning in asm-ppc/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig <hch@lst.de> wrote:
>
>  A function must not return a const value, instead use
>  __attribute_const__.
> 
> 
>  Index: linux-2.6/include/asm/time.h
>  ===================================================================
>  --- linux-2.6.orig/include/asm/time.h	2005-04-30 10:17:19.000000000 +0200
>  +++ linux-2.6/include/asm/time.h	2005-08-01 11:57:12.000000000 +0200

asm-ppc, please.  That didn't apply very well on an x86 tree...
