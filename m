Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D07767A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 08:28:00 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <stuart.yoder@conformative.com>
In-Reply-To: <054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
References: <054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 08:27:29 +1000
Message-Id: <1114554449.7183.69.camel@gaston>
Mime-Version: 1.0
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Subject: RE: PowerPC + SMP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-26 at 09:54 -0500, Stuart Yoder wrote:
> Thanks Ben.
> 
> That raises a question though-- how can I know what assumptions the
> kernel makes about the state of the CPU/system when it begins execution?
> Is this clearly documented anywhere?
> 
> I am using U-boot on my SMP system and U-boot is not SMP aware.  Do you
> know of other open source bootloaders for Linux that would set up the
> CPUs as the kernel expects.

No, it's up to you to configure the CPU properly. I'm surprised that
uBoot doesn't set it up properly though, but then, when you bringup a
board, you rarely use a bootloader like that "as-is" :)

In general, the kernel except the CPU to be in working condition, which
I consider meanings having necessary HID bits set for proper coherency
etc... on an SMP system :)

Ben.
