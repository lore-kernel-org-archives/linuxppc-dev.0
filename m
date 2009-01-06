Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51094DE4CA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 23:03:35 +1100 (EST)
Subject: Re: Lock-up on PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: malc <av1474@comtv.ru>
In-Reply-To: <Pine.LNX.4.64.0901051928200.2208@linmac.oyster.ru>
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<20081222233223.GA6688@joi> <877i5rh9rm.fsf@linmac.oyster.ru>
	<20081223234513.GA8730@deepthought> <871vvy77v4.fsf@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
	<1231158516.8367.3.camel@localhost>
	<Pine.LNX.4.64.0901051928200.2208@linmac.oyster.ru>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 23:02:53 +1100
Message-Id: <1231243373.14860.24.camel@pasglop>
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

On Mon, 2009-01-05 at 19:34 +0300, malc wrote:
> Before this change (atleast) mono_handle_native_sigsegv was executed
> (before machine locks-up hard) after the change this code path is
> never touched.
> 
> The fact that machine locks up hard and not even magic sysrq works
> is what deserves a better look.

Indeed. It's possible that the normally not hit error case is triggering
a different bug. Definitely worth looking at.

I didn't have a chance so far, I'm a bit swamped at the moment, but keep
pining me please :-)

Cheers,
Ben.
