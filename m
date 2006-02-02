Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A37E368A44
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 20:46:44 +1100 (EST)
Date: Thu, 2 Feb 2006 01:46:41 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060202094641.GB12810@gate.ebshome.net>
References: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 09:35:56AM -0000, Jenkins, Clive wrote:
> A driver for some device that could be connected to (or plugged into)
> a variety of different platforms of different architecture.
> A driver for a core that could be implemented within an FPGA on
> multiple platforms.

Well, this is all nice but I was wondering about _real_ examples.
When you are talking about "connecting" or "plugging" you have to keep 
in mind actual bus interconnect. So far AFAIK PCI (and derivatives) 
are the only cross-arch bus.

So basically, you have no _real_ life examples, so I'm wondering why 
people need this "arch-independent" non-PCI I/O accessors for 
something which doesn't exist.

I think the reason why Linux doesn't have this stuff follows from the 
previous paragraph.

-- 
Eugene
