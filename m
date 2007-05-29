Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E23D7DDF6E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:28:18 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:27:59 +1000
Message-Id: <1180474079.19517.188.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 15:04 +0200, Segher Boessenkool wrote:
> 
> Just call them and trap the SEGV ;-)  You can check the
> aux vector of course, or ask glibc -- but the SEGV way
> is the only really portable way.  Strange world :-)

SIGILL you mean ? :-)

Ben.
