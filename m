Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D480DE35F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 10:41:34 +1000 (EST)
Date: Sat, 18 Apr 2009 10:40:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Example dts file
Message-ID: <20090418004018.GA6187@yookeroo.seuss>
References: <49E8B69A.8010005@embeddedarm.com>
	<fa686aa40904171012i7f67f6b6sae9a7fd4ff8e3807@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40904171012i7f67f6b6sae9a7fd4ff8e3807@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 11:12:43AM -0600, Grant Likely wrote:
> On Fri, Apr 17, 2009 at 11:04 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> > Hello,
> >
> > I'm working on creating a dts file for a custom board based on the Yosemite
> > AMCC 440EP evaluation board. We have an FPGA connected to the PCI bus, and
> > I'm a bit unsure how to describe this in the dts file. The FPGA implements
> > an SD card core, RTC core, Nand core... Can anyone point me to an example
> > dts file I can refer to?
> 
> If it is attached to the PCI bus, then you don't need to describe it
> in the .dts file.  PCI can reliably probe for devices.  Your driver
> should know what devices are present based on the PCI vendor and
> device IDs.

However, for onboard PCI devices it's often necessary to have a node
giving at least the interrupt routing information, because this can't
generally be probed by PCI.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
