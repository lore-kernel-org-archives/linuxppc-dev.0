Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B919DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 10:14:05 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <51b3a75638604c9dd7ed60a10f0ed934@kernel.crashing.org>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
	<464CB460.40905@ru.mvista.com>
	<97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>
	<1179464690.32247.370.camel@localhost.localdomain>
	<1179466769.3658.0.camel@localhost.localdomain>
	<1179472096.32247.394.camel@localhost.localdomain>
	<464DAD06.2060504@ru.mvista.com>
	<1179530872.32247.423.camel@localhost.localdomain>
	<51b3a75638604c9dd7ed60a10f0ed934@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 19 May 2007 10:13:16 +1000
Message-Id: <1179533596.32247.429.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dave Liu <r63238@freescale.com>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-19 at 01:49 +0200, Segher Boessenkool wrote:
> > I find it extremely silly to implement it as edge anyway. The EE line 
> > is
> > level triggered, and having a mix of edge and level on the same
> > exception without a clean way to retrigger the DEC one other than
> > waiting one tick is just causing trouble.
> 
> It isn't edge triggered, it just automatically clears the
> decrementer exception condition at its source when taken

Which is exactly the same thing software-wise as edge triggered... 

Ben.
