Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZTNY5wPDzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 11:41:33 +1100 (AEDT)
Message-ID: <1459298493.25307.6.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: mm: fixup preempt undefflow with huge pages
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Mackerras
 <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 11:41:33 +1100
In-Reply-To: <20160329134024.GA25057@breakpoint.cc>
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
 <1457394104.2943.69.camel@kernel.crashing.org>
 <20160308090356.GA21842@linutronix.de> <87bn6n1m4f.fsf@linux.vnet.ibm.com>
 <20160329134024.GA25057@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 15:40 +0200, Sebastian Andrzej Siewior wrote:

> On 2016-03-10 01:04:24 [+0530], Aneesh Kumar K.V wrote:

> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> *ping*
> http://patchwork.ozlabs.org/patch/593943/

*pong*

The merge window just closed, I'm still recovering.

I've got it in my fixes branch locally, I'll probably push that today to
linux-next.

cheers
