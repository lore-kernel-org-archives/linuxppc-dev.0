Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC5671007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 14:29:22 +1100 (EST)
Message-ID: <1329362944.3772.45.camel@pasglop>
Subject: Re: [PATCH 6/12] arch/powerpc: remove references to cpu_*_map.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 16 Feb 2012 14:29:04 +1100
In-Reply-To: <4F3B790F.1040907@linux.vnet.ibm.com>
References: <1329281884.20466.rusty@rustcorp.com.au>
 <4F3B790F.1040907@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Venkatesh Pallipadi <venki@google.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-15 at 14:51 +0530, Srivatsa S. Bhat wrote:
> On 02/15/2012 10:28 AM, Rusty Russell wrote:
> 
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > This has been obsolescent for a while; time for the final push.
> > 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Want me to stick that in -powerpc ? If yes, now or -next ?

Cheers,
Ben.
