Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24637DE351
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 08:00:43 +1000 (EST)
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080811170756.GA29827@oksana.dev.rtsoft.ru>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>
	<20080811170756.GA29827@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 12 Aug 2008 08:00:32 +1000
Message-Id: <1218492032.8041.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>, linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 1. IDE status read does not work. (But am I understand correctly
>    that IDE works well if IRQ is unspecified? Then this is hardly
>    an issue.)
> 2. IDE interrupt comes when it should not. I'd recommend to use
>    oscilloscope to find out what is happening there, that is, if
>    the drive actually deasserts its irq line after status read.
>    If so, than this could be a PIC problem.
> 
> What is the platform on which you're observing the issue, btw?

Another possibility is that you got the wrong interrupt number
in the device-tree...

Ben.
