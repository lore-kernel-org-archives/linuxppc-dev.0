Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 490511A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 19:09:09 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: mm: fixup preempt undefflow with huge pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
 <1457394104.2943.69.camel@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Lameter <cl@linux.com>, Tiejun Chen <tiejun.chen@windriver.com>,
 Scott Wood <scottwood@freescale.com>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <56DE8891.3090105@linutronix.de>
Date: Tue, 8 Mar 2016 09:08:49 +0100
MIME-Version: 1.0
In-Reply-To: <1457394104.2943.69.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2016 12:41 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2016-03-07 at 21:04 +0530, Aneesh Kumar K.V wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>  
>> While you are there, can you also fix the wrong indentation on line
>> 423
>> ?
> 
>  .../...
> 
> Also this looks like stable material no ?

Yes, I had a stable tag attached. I am going to resend it with the
additional changes Aneesh asked for.

> Cheers,
> Ben.
> 
Sebastian
