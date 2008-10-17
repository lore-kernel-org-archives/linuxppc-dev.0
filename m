Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B06D4DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 18:22:42 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: Problems with PCI-E devices not being detected with switch
Date: Fri, 17 Oct 2008 09:22:38 +0200
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
In-Reply-To: <1224202209.7654.36.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810170922.38928.sr@denx.de>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 October 2008, Benjamin Herrenschmidt wrote:
> Ok, can you send me a full dmesg log with "debug" on the kernel command
> line after adding a #define DEBUG 1 to the top of drivers/pci/probe.c
> please ? (before the batch of #include).
>
> The generic code is _supposed_ to somewhat figure out that bridges
> haven't been setup by the firmware and fix that up, but for some reason
> it's not happening I think. Or something else is wrong ...
>
> Stefan, I could use the same log from your customer too.

OK. I'll try to provide those logs quickly.

Best regards,
Stefan
