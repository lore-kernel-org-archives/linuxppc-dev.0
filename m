Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82498DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 07:51:50 +1000 (EST)
Subject: Re: "Badness at kernel/irq/resend.c:70" on boot - via-pmu?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708042139300.5037@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708032031480.5037@woody.linux-foundation.org>
	<87sl6ypsx2.fsf@briny.wgtn.ondioline.org>
	<alpine.LFD.0.999.0708042139300.5037@woody.linux-foundation.org>
Content-Type: text/plain
Date: Mon, 06 Aug 2007 07:51:44 +1000
Message-Id: <1186350704.938.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-08-04 at 21:41 -0700, Linus Torvalds wrote:
> 
> On Sun, 5 Aug 2007, Paul Collins wrote:
> > 
> > I got the message below on boot with 2.6.23-rc2 on my PowerBook.
> 
> It's a debug message, I think we need to remove it. It's trying to figure 
> out what goes wrong with one particular machine, and I probably shouldn't 
> have merged it for mainline.
> 
> Ignore it, it will be gone soon enough, and it should happen just once per 
> boot.

Actually, it's interesting as that irq shouldn't hit that path :-) Not
critical (won't break anything), but still something I'll look into just
in case it hides something bad.

Cheers,
Ben.
