Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 49FF9B70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 21:33:15 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71D46DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 21:33:14 +1000 (EST)
Subject: Re: 85xx Address space query
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kernel mailz <kernelmailz@googlemail.com>
In-Reply-To: <abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
	<abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 21:33:01 +1000
Message-Id: <1245929581.22312.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-24 at 23:16 +0530, kernel mailz wrote:
> But If the app was running with PID=1, interrupt occurs, kernel code
> gets executed in PID=1, how does the kernel handle this ? and goes
> back to PID=0, since its translations are all in PID=0

PID 0 is a special case in HW. TLB entries with TID=0 will match any PID
value.

Cheers,
Ben.
