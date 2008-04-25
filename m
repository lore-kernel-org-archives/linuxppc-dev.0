Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF6A2DDF50
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:43:14 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3PAh7T5005193
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 06:43:07 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3PAh6RL227720
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 06:43:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3PAgu1K011401
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 06:42:56 -0400
Date: Fri, 25 Apr 2008 05:37:24 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Message-ID: <20080425053724.5b3eeb2f@zod.rchland.ibm.com>
In-Reply-To: <1209104641.9060.228.camel@pasglop>
References: <1208789670-28909-1-git-send-email-sr@denx.de>
	<1209104641.9060.228.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Apr 2008 16:24:01 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2008-04-21 at 16:54 +0200, Stefan Roese wrote:
> > This patch adds basic endpoint support to the 4xx PCIe driver.
> > 
> > This is done by checking the device_type property of the PCIe
> > device node ("pci" for root-complex and "pci-endpoint" for endpoint
> > configuration).
> > 
> > Note: Currently we map a fixed 64MByte window to PLB address 0 (SDRAM).
> > This should probably be configurable via a dts property.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Paul, I forgot to send that ack a while ago, this is .26 material, been
> around for some time.

I'll add it to my tree.  And this version of the patch was only sent
out on Monday.

josh
