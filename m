Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78F38679E7
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 06:44:00 +1000 (EST)
Subject: Re: PowerBook5,4 -- no sound?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je1wvxo70l.fsf@sykes.suse.de>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 06:43:53 +1000
Message-Id: <1145220233.9833.11.camel@localhost.localdomain>
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

On Sun, 2006-04-16 at 17:49 +0200, Andreas Schwab wrote:
> Paul Collins <paul@briny.ondioline.org> writes:
> 
> > With Linus's current git plus the boot fix and some unrelated patches
> > (console font and bluetooth) sound no longer seems to work (nothing in
> > /proc/asound/cards), although snd-powermac loaded without complaint.
> > Is this a known problem?
> 
> Sound doesn't work here on PowerMac7,3 either, it even oopses during
> module loading.

Same reply... load i2c-powermac before snd-powermac. It's a bug in the
sound driver, but I can't be bothered fixing it at this point, better to
concentrate on the new snd-aoa and adapting it to work on all machines.

Ben.
