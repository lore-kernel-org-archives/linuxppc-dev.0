Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11DAD1A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:42:39 +1100 (AEDT)
Message-ID: <1457394104.2943.69.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mm: fixup preempt undefflow with huge pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Lameter <cl@linux.com>, Tiejun Chen <tiejun.chen@windriver.com>,
 Scott Wood <scottwood@freescale.com>
Date: Tue, 08 Mar 2016 10:41:44 +1100
In-Reply-To: <877fheti8i.fsf@linux.vnet.ibm.com>
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
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

On Mon, 2016-03-07 at 21:04 +0530, Aneesh Kumar K.V wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> While you are there, can you also fix the wrong indentation on line
> 423
> ?

 .../...

Also this looks like stable material no ?

Cheers,
Ben.
