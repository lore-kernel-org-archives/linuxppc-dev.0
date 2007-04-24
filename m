Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7513DDF94
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:29:45 +1000 (EST)
Subject: Re: [PATCH 6/7] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070423035025.GA29839@lixom.net>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 11:29:29 +1000
Message-Id: <1177378169.14873.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's time to rename BROKEN_U3. It used to be the config option to enable
> a few workarounds, but now it's used to select whenever there's a U3 in
> the system. Care to do it in the scope of this patch set?

Not really.... first gen G5s don't use that :-) It's wether the MPIC is
part of U3/U4 -and- is used as a primary HT PIC.

Ben.
