Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ5z606CSzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 21:06:42 +1100 (AEDT)
Date: Tue, 29 Mar 2016 21:06:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
Message-ID: <20160329210639.12136fd5@canb.auug.org.au>
In-Reply-To: <56FA435A.5010804@ozlabs.org>
References: <20160329175944.33a211cc@kryten>
	<56FA435A.5010804@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeremy,

On Tue, 29 Mar 2016 16:56:58 +0800 Jeremy Kerr <jk@ozlabs.org> wrote:
>
> From the mail that Anton has sent to linuxppc-dev:
> 
> > From: Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> > Reply-To: Anton Blanchard <anton@samba.org>  
> 
> Do you know why mailman would be re-writing From: there? It's confusing
> patchwork, as multiple mails are now coming from that address.

Yep, Anton posts from samba.org.  They publish a DMARC policy that
breaks mailing lists.  The best thing we can do is to do the above
rewrite of the From header.

The alternative is that all our Yahoo, Gmail and Hotmail subscribers
(at least) would bounce the email.

So this rewriting will happen for any From: line that has an address
that has such a DMARC policy.  We have had posts from Yahoo subscribers
bounced in the past.
-- 
Cheers,
Stephen Rothwell
