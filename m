Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 77A59DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 00:07:25 +1000 (EST)
Date: Wed, 13 Jun 2007 09:14:52 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Don't use long for 32-bit temp variables in spin
	lock ops
Message-ID: <20070613141452.GA9822@lixom.net>
References: <20070607170816.GA4273@lixom.net>
	<18031.29567.757635.864638@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18031.29567.757635.864638@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2007 at 02:33:03PM +1000, Paul Mackerras wrote:

> > Note the cmpdi at ..78 when r9 was loaded with lwarx.
> 
> That's OK; the lwarx is defined to zero-extend the value to 64 bits.
> 
> Or are you implying that cmpdi is slower than cmpwi on some 64-bit
> processors? :)

Nope, it was just seemed inconsistent to me, especially since the
preceding (asm) comparison was 32-bit.


-Olof
