Return-Path: <mgroeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 980672BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 19:43:11 +1000 (EST)
Date: Tue, 21 Sep 2004 11:15:20 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
Sender: mag@sysgo.com
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20040920122312.A8344@home.com>
Message-ID: <Pine.LNX.4.61.0409211112400.2255@mag.sysgo.com>
References: <414916BD.9080607@sonartech.com.au>
	<20040915223624.A25752@home.com>
	<414946A0.1020306@sonartech.com.au>
	<20040920173241.GL27914@smtp.west.cox.net>
	<20040920122312.A8344@home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Mon, 20 Sep 2004, Matt Porter wrote:

>> Did you disable CONFIG_VT, if it was enabled?  Otherwise you need to
>> pass console=ttyS0
>
> and on recent kernels, you need console=ttyS0,9600 on boards like
> this that use 9600 baud. Baud rate used to default to 9600, but
> no longer.

So what IS the default then? Until today, I thought you don't necessarily
need a console= argument at all. See Documentation/serial-console.txt:

    If no console device is specified, the first device found capable of
    acting as a system console will be used. At this time, the system first
    looks for a VGA card and then for a serial port. So if you don't have a
    VGA card in your system the first serial port will automatically become
    the console.

Are you saying that you should always pass console=...?

Regards,
Marius

-- 
Marius Groeger <mgroeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
