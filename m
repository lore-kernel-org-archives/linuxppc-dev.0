Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 50A45DE067
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 13:42:43 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M6zB1-0008IE-1W
	for linuxppc-dev@ozlabs.org; Wed, 20 May 2009 20:42:39 -0700
Message-ID: <23647394.post@talk.nabble.com>
Date: Wed, 20 May 2009 20:42:39 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: question : DMA of PCI bridge
In-Reply-To: <4A137E4F.4040900@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23628338.post@talk.nabble.com> <4A137E4F.4040900@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


thank you dave for your reply 

my processor is MPC8247, on Linux 2.6.11


in MPC8247 manual reference, the interrupt of DMA unit belonged PCI bridge.
that is different from SDMA and IDMA. through i do not know what 's the
different. heard SDMA is used to transfer between CPM and 60x. DMA is used
to transfer between 60x bus and PCI, or 60x bus - 60x bus. i am not sure.

> Whether or not you get packing bytes when you access a
> 16-bit device and transfer the data to a 32-bit destination
> depends on how the device is mapped. For example, a 16-bit
> device can be implemented such that it responds to 8-bit,
> 16-bit, and 32-bit requests, but the 32-bit requests will
> require more wait-states, since the device has to be
> read from twice before constructing a 32-bit word to
> place on the PCI bus.

ya, that's it

> Its also possible that the DMA controller can be configured
> to deal with different source and destination widths. However
> without knowing what processor or DMA controller you are
> asking about, theres not much to say.

in the manual reference charpter 9.13 DMA,  source and destination address
can be configured. i can not find the hint about source and destination
widths configured.
-- 
View this message in context: http://www.nabble.com/question-%3A-DMA-of-PCI-bridge-tp23628338p23647394.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
