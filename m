Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 679842BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jan 2005 20:50:13 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <41D97734.3070800@246tNt.com>
References: <200412301246.48870.david.jander@protonic.nl>
	<C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
	<061001c4eeaf$0b5e1860$0301a8c0@chuck2> <41D7269E.1070906@246tNt.com>
	<003c01c4f19d$98a16510$0301a8c0@chuck2> <41D97734.3070800@246tNt.com>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 10:37:39 +0100
Message-Id: <1104831459.11260.4.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC5200 PCI byte-swapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-03 at 17:47 +0100, Sylvain Munaut wrote:
> >Thanks.  I had an older manual that didn't spell it out so
> >clearly.
> >
> >I've been trying to interpret the PCI sections for some other
> >82xx family parts, and it appears that they do NOT do this
> >byte lane swapping, so this make the 5200 non-standard in
> >this regard, which is unfortunate.  If I'm understanding this
> >right, one would have to have different drivers for a PCI
> >device on a 5200 and an 8270, for instance.
> >  
> >
> Mmmm ...
> Still I use the intel eepro driver without problems or modifications.
> As long as the driver uses the proper readl/writel that should do
> it or am I mistaken ?

This reminds me of an issue with the Coral P PCI graphics chip I
encountered a while ago. The driver is from the Denx CVS and was
apparently developed on a 5200.

When I tried it on a mpc8540, the console text looked blueish, but I
could not investigate further. But I know where I'd look at now ...

-- 
Stefan Nickl
Kontron Modular Computers
