Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler2.mail.xerox.com (wbmler2.mail.xerox.com [13.13.138.217])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wbmler2.mail.xerox.com",
	Issuer "wbmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5B3C768A37
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 21:40:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Yosemite/440EP why are readl()/ioread32() setup
	toreadlittle-endian?
Date: Thu, 2 Feb 2006 10:28:05 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D921D@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
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

> > On Thu, Feb 02, 2006 at 09:35:56AM -0000, Jenkins, Clive wrote:
> > A driver for some device that could be connected to (or plugged
into)
> > a variety of different platforms of different architecture.
> > A driver for a core that could be implemented within an FPGA on
> > multiple platforms.

> Well, this is all nice but I was wondering about _real_ examples.
> When you are talking about "connecting" or "plugging" you have to keep

> in mind actual bus interconnect. So far AFAIK PCI (and derivatives)=20
> are the only cross-arch bus.

Yes, I do realise that in most cases PCI is used for cross-arch
interconnect. But without knowing about all the relevant hardware in the
world, I couldn't say that there are no other cross-arch buses.
And what about direct connection to the local bus of the processor chip?
=20
> So basically, you have no _real_ life examples, so I'm wondering why=20
> people need this "arch-independent" non-PCI I/O accessors for=20
> something which doesn't exist.

I could draft a design of such an example, and I could realise that
design
by building it. But I don't want to spend the time and money doing it.
Neither do I want to spend time researching _real_ examples.
It is much easier to allow for obvious possibilities that _could_ exist
and probably will exist if they don't already, than searching the world.

Why be PCI-centric now, when we have experienced no end of problems
because Linux was x86-centric in the past?

> I think the reason why Linux doesn't have this stuff follows from the=20
> previous paragraph.

Clive
