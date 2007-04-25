Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80CEBDDF1D
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:09:10 +1000 (EST)
Subject: Re: [PATCH] generic check_legacy_ioport
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070424185402.GA16077@aepfle.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070423081540.GA28244@aepfle.de>
	<1177376000.14873.38.camel@localhost.localdomain>
	<20070424112530.GA11489@aepfle.de> <20070424185402.GA16077@aepfle.de>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:09:03 +1000
Message-Id: <1177459743.14873.167.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 20:54 +0200, Olaf Hering wrote:
> On Tue, Apr 24, Olaf Hering wrote:
> 
> > > And also check now if the parent is "isa". Just to be sure. If a
> > > platform won't match that, then it will need it's own
> > > check_legacy_ioport which is fine with me.
> > 
> > Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
> > node?
> 
> Does anyone know where those ipmi devices appear in the device-tree?

Somebody with an up-to-date qs21 device-tree at hand ?

Ben.
