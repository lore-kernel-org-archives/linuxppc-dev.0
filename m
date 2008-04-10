Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 83D58DE323
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 23:44:25 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Thu, 10 Apr 2008 15:37:27 +0200
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<200804101359.32095.sr@denx.de> <1207830182.6958.11.camel@pasglop>
In-Reply-To: <1207830182.6958.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804101537.27417.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008, Benjamin Herrenschmidt wrote:
> > Understood. But for this "dynamic" root-complex/endpoint configuration as
> > implemented with the current version of the patch, I can't change the
> > PCIe node in the dts from root-complex mode to endpoint mode, since I
> > would loose root-complex functionality. Perhaps I'm missing something
> > here.
>
> Well, I would expect the firmware (ie. uboot) to provide the right
> device-node type...

Now I have to re-check to see what you really have in mind. Do you think about 
creating two different PCIe nodes, one for root-complex and one for endpoint 
functionality? Or is your idea to add a property to the existing PCIe 
device-tree node (like "mode = endpoint"), or perhaps change the device_type 
from "pci" to "pci-endpoint"? I would vote for the latter.

Best regards,
Stefan
