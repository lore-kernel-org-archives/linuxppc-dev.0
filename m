Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0640100802
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 13:08:05 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <1276311610.1962.173.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<1276311610.1962.173.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Jun 2010 13:07:51 +1000
Message-ID: <1276312071.1962.175.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-06-12 at 13:00 +1000, Benjamin Herrenschmidt wrote:
> 
> Quite nice. Maybe the introduction could use a very  quick blurb on
> the
> various data types that dtc supports for properties, and something on
> labels & phandles (references to nodes).
> 
> I just flew over it. I'll try to give you a more in depth review
> later.

Oh, yes, btw, Dan is right, you do seem to mixup "model" and
"compatible" all over the place :-)

Maybe a paragraph on the new proposed clock binding that Jeremy is
working would be of use btw.

Cheers,
Ben.
