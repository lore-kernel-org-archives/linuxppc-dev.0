Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 006AEDDF2D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:51:29 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so338439ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 08:51:28 -0700 (PDT)
Date: Tue, 23 Sep 2008 11:50:26 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: AMCC 440 SPI question
Message-ID: <20080923155026.GA14099@yoda.jdub.homelinux.org>
References: <48D90D5D.5000105@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48D90D5D.5000105@harris.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 11:38:05AM -0400, Steven A. Falco wrote:
>The yosemite.dts has the following entry, which leads me to believe
>that there is SPI support.  I'd like to do something similar for a
>Sequoia board, but looking in Josh's "next" branch, I don't see any
>driver that would recognize the spi-440ep string.  So my question is,
>is there a SPI driver for the PPC440, that is .dts aware?

There is no mainline driver, no.  There might be one in the DENX kernel
tree.

>
>			spi@ef600900 {
>				compatible = "amcc,spi-440ep";
>				reg = <ef600900 6>;
>				interrupts = <8 4>;
>				interrupt-parent = <&UIC0>;
>			};
>
>Also, googling for a driver, I find the patch that introduced this
>.dts file:
>
>Patch: [PATCH 1/3][POWERPC] 4xx: Add AMCC 440EP Yosemite DTS
>patchwork.ozlabs.org/linuxppc/patch?id=16992
>
>However, when I click on the patchwork link, I get a 404 error.
>Perhaps this just means the patch is old and has been removed
>from patchwork.  But since it is a "1 of 3", I was hoping one of
>the other parts would contain the actual spi-440ep driver code.

Patchwork was updated to a new version recently and the old one was either
taken offline or moved elsewhere.  The set of patches that added Yosemite
didn't include an SPI driver (I know, I wrote them).  I just enumerated
the device in the DTS because it's on the board.

josh
