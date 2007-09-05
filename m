Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BC923DDFD3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 07:57:07 +1000 (EST)
Date: Wed, 5 Sep 2007 16:57:08 -0500
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] CPM: Change from fsl, brg-frequency to
	brg/clock-frequency
Message-ID: <20070905215708.GA8718@lixom.net>
References: <20070905191313.GA31927@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905191313.GA31927@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:13:13PM -0500, Scott Wood wrote:
> As suggested by David Gibson, now that we have a separate node
> for the baud rate generators, it's better to use the standard
> clock-frequency property than a cpm-node-level fsl,brg-frequency
> property.
> 
> This patch updates existing places where fsl,brg-frequency is
> used.

What about older platforms that were booted with the older device
tree? Don't you have to stay compatible with them? Think kexec of a
system running a kernel with the older device tree, for example.


-Olof
