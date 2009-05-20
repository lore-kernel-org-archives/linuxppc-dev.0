Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69FCADE230
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:02:19 +1000 (EST)
Subject: RE: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20090519162511.7454D17E8058@mail19-dub.bigfish.com>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<20090519162511.7454D17E8058@mail19-dub.bigfish.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 13:02:02 +1000
Message-Id: <1242788522.16901.134.camel@pasglop>
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

On Tue, 2009-05-19 at 09:25 -0700, Stephen Neuendorffer wrote:

> I agree that something is called for...  The first might be slightly
> simpler, since it would probably transparently deal with the presence
> of more than one PLB->PCI bridge?

The current code doesn't already ?

Cheers,
Ben.
