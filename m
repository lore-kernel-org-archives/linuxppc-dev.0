Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0DD4DDE6F6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:52:16 +1100 (EST)
Date: Fri, 25 Jan 2008 19:04:09 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: drivers/char/hvc_* and /Documentation/powerpc/hvcs.txt
Message-ID: <20080126010409.GA25717@lixom.net>
References: <479A651F.2070109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <479A651F.2070109@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 04:39:27PM -0600, Timur Tabi wrote:
> Hi,
> 
> I'm working on a console driver for the Freescale hypervisor.  I notice a bunch 
> of hvc_* files in the drivers/char directory.  I also noticed 
> /Documentation/powerpc/hvcs.txt.
> 
> My guess is that hvcs.txt talks about drivers/char/hvcs.c, which is a console 
> driver specific to some IBM hypervisor.  The hvc_*.c files are based on that 
> code but they're more generic and allow people to write console drivers for 
> other hypervisors easliy.  Am I right?

Hvcs is the server-side driver in some environments. I.e. a hvc console
connects through the hypervisor to a hvcs in another partition.

> If so, does this mean that I can take hvc_beat.c, modify it to make Freescale 
> hypervisor calls instead, and presto, I'm done?

Yep, pretty much. It's real easy to write a new backend to hvc, I've got
a couple for various bringup environments here as well.


-Olof
