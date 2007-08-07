Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3825ADDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 02:25:59 +1000 (EST)
Message-ID: <46B89D5D.9090506@genesi-usa.com>
Date: Tue, 07 Aug 2007 17:27:09 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Alan Curry <pacman@theworld.com>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
References: <200708070416.l774G3Qf728075@shell01.TheWorld.com>
In-Reply-To: <200708070416.l774G3Qf728075@shell01.TheWorld.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Okay, you don't need to be an experienced Open Firmware developer.

In fact I know we have had experienced Open Firmware developers who have
said that our firmware sucks (some comment about "shitty German engineering",
I really did quit caring after that point) because they could not run probe-all
from the "ok" prompt.

In the first few pages of the OF spec, it very clearly states that this will
probably make your system explode.

So even experts do not know what they are doing. I don't expect users to.
But as an engineer, here, I think patching the device-type in the boot
wrapper (be it the chrp boot loader) is the wrong place, because we have
had real experts here (Ben, Segher etc.) complain that fixing the device
tree in the boot wrapper is no substitute for a correctly working
firmware.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Curry wrote:
> I'm almost sorry I spoke up...
> 
> Matt Sealey writes the following:
>> Okay before you add to the nvramrc you also need to add probe-all to build the
>> device tree first; I assumed this was common knowledge.
> 
> Maybe for experienced OpenFirmware developers; this is the first time I've
> had to touch the stuff. So first I had to learn Forth. To patch the kernel
> you only need to know C. (Of course I already knew C -- it's common
> knowledge.)
> 
