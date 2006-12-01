Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F125867BD4
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 05:51:17 +1100 (EST)
Date: Fri, 1 Dec 2006 18:58:16 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061201185816.074c0e05@localhost.localdomain>
In-Reply-To: <20061201183355.GA9701@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de>
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

On Fri, 1 Dec 2006 19:34:16 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> > The printk in pci_request_region has 'bar + 1', so 6 should be possible
> > if i becomes 5.
> 
> Does the IO region of the last bar look correct?

I've no idea. That really depends upon the platform.
