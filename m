Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZgWG1z4dzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:18:02 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc: mm: fixup preempt undefflow with huge pages
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
 <1457394104.2943.69.camel@kernel.crashing.org>
 <20160308090356.GA21842@linutronix.de> <87bn6n1m4f.fsf@linux.vnet.ibm.com>
 <20160329134024.GA25057@breakpoint.cc>
 <1459298493.25307.6.camel@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <56FB8BB2.4010707@linutronix.de>
Date: Wed, 30 Mar 2016 10:17:54 +0200
MIME-Version: 1.0
In-Reply-To: <1459298493.25307.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2016 02:41 AM, Michael Ellerman wrote:
> The merge window just closed, I'm still recovering.
> 
> I've got it in my fixes branch locally, I'll probably push that today to
> linux-next.

Thank you.

> 
> cheers
> 
Sebastian
