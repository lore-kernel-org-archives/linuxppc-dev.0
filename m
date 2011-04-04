Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 168FCB6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 07:21:04 +1000 (EST)
Subject: Re: [RFC/PATCH] of: Match PCI devices to OF nodes generically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
References: <1301882694.2549.53.camel@pasglop>
	<1301887630.2549.71.camel@pasglop> <1301902664.2549.76.camel@pasglop>
	<BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 07:03:57 +1000
Message-ID: <1301951037.2549.85.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-04 at 09:25 -0600, Bjorn Helgaas wrote:
> 
> Some of this is reminiscent of the ACPI/PCI binding we do on x86/ia64,
> e.g., acpi_get_pci_dev() and the stuff in drivers/acpi/glue.c.  Have
> you looked at that to see if there's any hope of covering both OF and
> ACPI with something more generic?

I haven't but I will have a look. Thanks.

Cheers,
Ben.
