Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 95E772C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 08:23:45 +1100 (EST)
Date: Fri, 07 Mar 2014 16:23:41 -0500 (EST)
Message-Id: <20140307.162341.1600860024275495539.davem@davemloft.net>
To: joe@perches.com
Subject: Re: rfc: checkpatch logical line continuations
From: David Miller <davem@davemloft.net>
In-Reply-To: <1394226164.16156.96.camel@joe-AO722>
References: <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
 <1394226164.16156.96.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: randy.dunlap@oracle.com, devicetree@vger.kernel.org, error27@gmail.com,
 alistair@popple.id.au, linux-kernel@vger.kernel.org, josh@joshtriplett.org,
 netdev@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Fri, 07 Mar 2014 13:02:44 -0800

> Right now, checkpatch emits a --strict only warning on "&&" or "||"
> at the beginning of line but that could be changed to any "$Operators"
> 
> our $Arithmetic = qr{\+|-|\*|\/|%};
> our $Operators	= qr{
> 			<=|>=|==|!=|
> 			=>|->|<<|>>|<|>|!|~|
> 			&&|\|\||,|\^|\+\+|--|&|\||$Arithmetic
> 		  }x;
> 
> The ones that likely have a too high false positive rates
> are the negation "!" and bitwise "~".

Unary operators at the beginning of a line are perfectly fine,
it's the other ones that are the problem.
