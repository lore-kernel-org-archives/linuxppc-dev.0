Message-ID: <3C79EC3C.7080404@embeddededge.com>
Date: Mon, 25 Feb 2002 02:48:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 405 DMA api
References: <3C795366.2040909@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Armin Kuster wrote:

> I would like to have the 405 dma share the same dma api as the current
> pmac.

Not a bad idea, since most DMA controllers are learning and becoming
descriptor based.  Please consider that DMA controllers, the devices
to which they are connected, and the integration is going to be unique
to the parts, boards and devices.  Forcing this to be too generic will
likely fail, make a mess of the software, and not benefit anyone.

Have fun!

	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
