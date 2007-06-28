Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D6C8DDF82
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 21:09:15 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature	utilization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vladislav Buzov <vbuzov@ru.mvista.com>
In-Reply-To: <468391B3.3080100@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
	<20070615212016.GB18055@mag.az.mvista.com>
	<1182429443.24740.8.camel@localhost.localdomain>
	<467BE91F.1030003@ru.mvista.com>
	<3372b921591ca9731d2703f04e6c35f1@kernel.crashing.org>
	<467FCC9D.6010904@ru.mvista.com>
	<ce09df5afe642e8f6e9a576306cc1e41@kernel.crashing.org>
	<1183022026.5521.269.camel@localhost.localdomain>
	<468391B3.3080100@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 28 Jun 2007 21:09:04 +1000
Message-Id: <1183028945.5521.274.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-28 at 14:47 +0400, Vladislav Buzov wrote:
> 
> I've looked through cache.S and see it contains a dcbf loop over 4Mb 
> along with L2, L3 HW cache flushing. The comments says 'Due to a bug 
> with the HW flush on some CPU revs, we occasionally experience data 
> corruption...'. Could you please clarify which CPU revisions have this 
> bug and whether it is the same bug described in errata and requiring a 
> complete cache locking before flushing? Do we still need to use the dcbf 
> loop in _set_L2CR() for MPC7450 processors?

Can't remember ... that code is pretty old now.

Cheers,
Ben.
