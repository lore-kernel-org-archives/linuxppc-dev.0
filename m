Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AAFC5DE099
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:04:08 +1100 (EST)
Date: Thu, 25 Jan 2007 23:43:52 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
Message-ID: <20070126064352.GA328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125083417.69895DE3C5@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org,
	"Eric W.Biederman" <ebiederm@xmission.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>,
	Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 07:34:16PM +1100, Michael Ellerman wrote:
> MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
...
> +		/* FIXME should we save the existing type */
> +		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);

What exactly does the "virq" represent here?
I'd like to understand if the FIXME comment could be dropped (or not).

I don't get the impression it's related to a PCI IRQ line.
Maybe irq_create_mapping() has comments that describe hwirq and virq?
If not, it would be useful if those terms were described.

thanks
grant
