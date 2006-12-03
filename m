Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCED267A5E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 10:00:09 +1100 (EST)
Date: Sun, 3 Dec 2006 23:07:20 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061203230720.65832f93@localhost.localdomain>
In-Reply-To: <20061203171216.GB21947@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I modified pci_request_regions to request only the first 5 regions.
> Now the detection works, but access to the drive does not work:

Some drives do that with the new EH code. Its ATAPI specific and I don't
know why. With the older libata it all works. It may also be a driver bug
but since it also pops up all over the place with the new EH code and not
the old its damn near impossible to debug any PATA problems that look
like this at the moment.

Alan
