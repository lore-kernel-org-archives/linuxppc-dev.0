Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CE31DE10B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 15:32:02 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905192017r7978fdddq70872dcf86127008@mail.gmail.com>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<20090519162511.7454D17E8058@mail19-dub.bigfish.com>
	<1242788522.16901.134.camel@pasglop>
	<fa686aa40905192017r7978fdddq70872dcf86127008@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 15:31:44 +1000
Message-Id: <1242797504.16901.135.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-19 at 21:17 -0600, Grant Likely wrote:
> On Tue, May 19, 2009 at 9:02 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2009-05-19 at 09:25 -0700, Stephen Neuendorffer wrote:
> >
> >> I agree that something is called for...  The first might be slightly
> >> simpler, since it would probably transparently deal with the presence
> >> of more than one PLB->PCI bridge?
> >
> > The current code doesn't already ?
> 
> Current code doesn't exist in mainline.  :-)

Well, I was thinking about ppc4xx_pci :-)

> And, no, the patch Roderick wrote doesn't handle more than one PHB.
> No reason it couldn't though.

Right, it shouldn't be hard.

Cheers,
Ben.
