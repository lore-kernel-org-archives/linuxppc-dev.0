Return-Path: <dibacco@libero.it>
Received: from cp-out3.libero.it (cp-out3.libero.it [212.52.84.103])
	by ozlabs.org (Postfix) with ESMTP id E7E1EDE006
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:11:12 +1100 (EST)
Date: Wed,  7 Jan 2009 22:11:09 +0100
Message-Id: <KD4DIL$CAE78B389ABC17D576E1A2B47EE54AEE@libero.it>
Subject: Re: __pa giving strange phys address on PPC
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@libero\.it" <dibacco@libero.it>
To: "jwboyer" <jwboyer@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I used __pa on the result of an uncached_mem_alloc. 
Furthermore __pa should work on the return of a kmalloc?

Thank you.
