Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FB2E67AC7
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 09:54:27 +1000 (EST)
Subject: Re: PowerBook5,4 -- no sound?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je7j5phz9j.fsf@sykes.suse.de>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 09:54:18 +1000
Message-Id: <1145231658.9833.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-17 at 01:33 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Same reply... load i2c-powermac before snd-powermac.
> 
> It's builtin.

i2c-powermac is built-in ans snd-powermac is a module or they are both
built-in ?

Ben.
