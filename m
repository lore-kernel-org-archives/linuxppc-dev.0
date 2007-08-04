Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E6FCDDE24
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 12:29:07 +1000 (EST)
Subject: Re: [patch 06/10] 40x decrementer fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46B3617B.10509@ru.mvista.com>
References: <20070803160900.069522000@linux.vnet.ibm.com> >
	<20070803161710.931656000@linux.vnet.ibm.com> >
	<46B35C07.4090806@ru.mvista.com>  <46B3617B.10509@ru.mvista.com>
Content-Type: text/plain
Date: Sat, 04 Aug 2007 12:28:57 +1000
Message-Id: <1186194537.5733.4.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 21:10 +0400, Sergei Shtylyov wrote:

> >     Why bother doing this?! This will only warrant you imprecise decrementer 
> > interrupts while it should be interrupting at the precise period currently (if 
> > you load PIT once)...
> 
>     I.e. the error will only accumulate. NAK.

No, it won't since the timebase is always used as the reference.

Ben.
