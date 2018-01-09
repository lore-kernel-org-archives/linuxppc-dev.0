Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGF8S4B1rzF0bM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 01:36:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
In-Reply-To: <20180109135453.28b36153@bahia.lan>
References: <20180109044815.GA19326@fergus.ozlabs.ibm.com>
 <1515487154.1993.3.camel@gmail.com>
 <2b9c6453-c56f-ac4d-daa9-16d9ffa6cebe@ozlabs.ru>
 <20180109135453.28b36153@bahia.lan>
Date: Wed, 10 Jan 2018 01:36:55 +1100
Message-ID: <87lgh7ksjc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <groug@kaod.org> writes:

> On Tue, 9 Jan 2018 23:44:56 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>> On 09/01/18 19:39, Suraj Jitindar Singh wrote:
> [...]
>> >> +	rc = plpar_get_cpu_characteristics(&c);
>> >> +	if (rc == H_SUCCESS) {
>> >> +		if (!(c.behavior &   
>> > 
>> > s/behavior/behaviour  
>> 
>> Why?
>> https://dictionary.cambridge.org/dictionary/english/behavior
>> 
>
> Behavior is US English while behaviour is UK (and US)... Matter of taste ? :)

Straya mate!

cheers
