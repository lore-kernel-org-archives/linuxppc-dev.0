Return-Path: <m@bues.ch>
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B559DB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jul 2011 23:03:15 +1000 (EST)
Date: Mon, 25 Jul 2011 15:03:04 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
Message-ID: <20110725150304.095a64bc@maggie>
In-Reply-To: <1311549818.25044.587.camel@pasglop>
References: <20110723222034.6757604b@maggie>
	<1311509250.25044.583.camel@pasglop>
	<20110724141051.771d6492@maggie>
	<1311509614.25044.585.camel@pasglop>
	<20110724143729.49c69ce8@maggie>
	<1311549818.25044.587.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jul 2011 09:23:38 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Hrm.. the faulting address is outside of the zImage. Odd.
> 
> Can you try loading a plain vmlinux instead ? (feel free to strip it).

The plain unstripped vmlinux boots fine:

mb@maggie:~$ uname -a
Linux maggie 3.0.0 #3 PREEMPT Sun Jul 24 11:51:30 CEST 2011 ppc GNU/Linux

Is there something going wrong in the uncompress trampoline?

-- 
Greetings, Michael.
