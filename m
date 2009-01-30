Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5909DE06B
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 15:10:04 +1100 (EST)
Subject: Re: 2.6.28-rt on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090130030758.GA7004@oksana.dev.rtsoft.ru>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	<1233281510.18767.17.camel@pasglop>
	<20090130030758.GA7004@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 30 Jan 2009 15:09:55 +1100
Message-Id: <1233288595.18767.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Actually, it doesn't matter whether a controller is a root IC or
> cascaded. Just as primary handlers, chained handlers don't run in
> threads, thus spinlocks should be used, not sleeping locks.

Sounds good then.

Cheers,
Ben.
