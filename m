Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8729C67B77
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 19:12:29 +1000 (EST)
Subject: Re: [PATCH] Lazy interrupt disabling for 64-bit machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060926011055.32d533e7@pb15>
References: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
	<20060926011055.32d533e7@pb15>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 19:12:06 +1000
Message-Id: <1159261926.5462.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I like it. Got any benchmarks that show a difference?
> 
> At first glance I found it a bit hard to follow, since the old+new
> terminology is a bit complicated. There's softe, proc_enabled and
> hard_enabled. A s/proc_enabled/soft_enabled/g (and similar for
> asm-offsets) might make it a little more intuitive, since you're
> touching most uses of it already?

Now think about using -ffixed=crN ... reserve a CR field and use that
for per-cpu flags like that :)

Ben.
