Return-Path: <srs0=7y9u=ee=kaod.org=groug@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGC1Q1CNfzF0PP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 00:00:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zGC1P1m1Tz8vRl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 00:00:41 +1100 (AEDT)
Received: from 1.mo5.mail-out.ovh.net (1.mo5.mail-out.ovh.net [188.165.57.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zGC1M2ZT9z9sBW
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2018 00:00:38 +1100 (AEDT)
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id A33D315D2E7
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 13:55:00 +0100 (CET)
Date: Tue, 9 Jan 2018 13:54:53 +0100
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paul Mackerras
 <paulus@ozlabs.org>, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
Message-ID: <20180109135453.28b36153@bahia.lan>
In-Reply-To: <2b9c6453-c56f-ac4d-daa9-16d9ffa6cebe@ozlabs.ru>
References: <20180109044815.GA19326@fergus.ozlabs.ibm.com>
 <1515487154.1993.3.camel@gmail.com>
 <2b9c6453-c56f-ac4d-daa9-16d9ffa6cebe@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Jan 2018 23:44:56 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 09/01/18 19:39, Suraj Jitindar Singh wrote:
[...]
> >> +	rc = plpar_get_cpu_characteristics(&c);
> >> +	if (rc == H_SUCCESS) {
> >> +		if (!(c.behavior &   
> > 
> > s/behavior/behaviour  
> 
> Why?
> https://dictionary.cambridge.org/dictionary/english/behavior
> 

Behavior is US English while behaviour is UK (and US)... Matter of taste ? :)

> 
> 
