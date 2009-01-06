Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22388DE35D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 08:18:07 +1100 (EST)
Subject: Re: Lock-up on PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: malc <av1474@comtv.ru>
In-Reply-To: <Pine.LNX.4.64.0901062032550.2972@linmac.oyster.ru>
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<20081222233223.GA6688@joi> <877i5rh9rm.fsf@linmac.oyster.ru>
	<20081223234513.GA8730@deepthought> <871vvy77v4.fsf@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
	<1231158516.8367.3.camel@localhost>
	<Pine.LNX.4.64.0901051928200.2208@linmac.oyster.ru>
	<1231243373.14860.24.camel@pasglop>
	<Pine.LNX.4.64.0901062032550.2972@linmac.oyster.ru>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 08:17:23 +1100
Message-Id: <1231276643.14860.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> As you wish :) I've written some ad-hoc stuff in the failing path which 
> manually triggers sysrq and then sends the klogctl output via network
> and here it is:

Allright, something's unclear to me. What do you mean by the system goes
down then ? The kernel appears to be working at least to a certain
extent if you manage to trigger a sysrq from userspace... And from what
I see, it looks that all processes are somewhere in schedule.

So what is precisely your symptom here ?

Cheers,
Ben.
