Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 4897B2C0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 05:36:25 +1000 (EST)
Date: Wed, 24 Apr 2013 12:36:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add HWCAP2 aux entry
Message-Id: <20130424123620.07e1c32890e53f758b92742b@linux-foundation.org>
In-Reply-To: <1366677702.2886.9.camel@pasglop>
References: <20130402212204.GA30438@linux.vnet.ibm.com>
 <20130405070559.GE5082@concordia>
 <27144.1366001074@ale.ozlabs.ibm.com>
 <31546.1366255991@ale.ozlabs.ibm.com>
 <32253.1366256478@ale.ozlabs.ibm.com>
 <1366677702.2886.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>, vda.linux@googlemail.com,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Steve Munroe <sjmunroe@us.ibm.com>, paulus@samba.org, viro@zeniv.linux.org.uk,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 23 Apr 2013 10:41:42 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2013-04-18 at 13:41 +1000, Michael Neuling wrote:
> > akpm,
> > 
> > If you're happy with this, is it something you can take in your tree?
> 
> Andrew ? Or give me an ack ? :-) I'm happy to carry this, we need that
> rather urgently and we have the glibc folks on board.

Looks good to me - please proceed with the patch.
