Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79D4467BAC
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Dec 2006 19:06:25 +1100 (EST)
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87lklg9rkz.fsf@briny.internal.ondioline.org>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 19:06:10 +1100
Message-Id: <1165737970.1103.171.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-12-10 at 19:45 +1300, Paul Collins wrote:
> On my PowerBook when booting Linus's tree as of commit af1713e0 I get
> something like this:
> 
>   [blah blah]
>   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
>   Probing IDE interface ide0...
>   hda: HTS541080G9AT00, ATA DISK drive
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
> 
> And then of course it fails to mount root.  No such problem using a
> kernel built from commit 97be852f of December 2nd.

I'll investigate tomorrow, looks like irq assignment got broken in a way
or another for that IDE controller.

Ben.
