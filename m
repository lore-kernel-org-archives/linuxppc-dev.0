Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19090DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 14:13:46 +1100 (EST)
Subject: Re: Please pull from 'next' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <46F4AA25-B5D1-42C1-B4EE-3EDE35D99782@kernel.crashing.org>
References: <Pine.LNX.4.64.0902171551460.23647@blarg.am.freescale.net>
	<1234923772.14060.322.camel@pasglop>
	<46F4AA25-B5D1-42C1-B4EE-3EDE35D99782@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 18 Feb 2009 14:13:40 +1100
Message-Id: <1234926820.14060.406.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-17 at 21:04 -0600, Kumar Gala wrote:
> ok. I was hoping for that one patch to migrate from test to next ;)
> 
Just pushed out to test, it has some collisions with merge and with
the ftrace stuff that I fixed up. I'll move it to next tomorrow, once
we've sorted out what tree the ftrace stuff is going through.

Ben.
