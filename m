Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 06F242BDAB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 03:32:49 +1000 (EST)
Date: Mon, 20 Sep 2004 10:32:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Message-ID: <20040920173241.GL27914@smtp.west.cox.net>
References: <414916BD.9080607@sonartech.com.au>
	<20040915223624.A25752@home.com>
	<414946A0.1020306@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414946A0.1020306@sonartech.com.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2004 at 05:54:08PM +1000, David Gardiner wrote:

> 
> >You need this patch:
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1192.html
> >
> >-Matt
> > 
> >
> Thanks that compiles, but it doesn't boot, I got:

Did you disable CONFIG_VT, if it was enabled?  Otherwise you need to
pass console=ttyS0

-- 
Tom Rini
http://gate.crashing.org/~trini/
