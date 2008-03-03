Return-Path: <bjorn.helgaas@hp.com>
Received: from g4t0015.houston.hp.com (g4t0015.houston.hp.com [15.201.24.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id EA61ADDF48
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:22:33 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources()
	implementations
Date: Mon, 3 Mar 2008 12:10:46 -0700
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.404893334@ldl.fc.hp.com>
	<200803031045.07054.jbarnes@virtuousgeek.org>
In-Reply-To: <200803031045.07054.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803031210.47906.bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 March 2008 11:45:06 am Jesse Barnes wrote:
> On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> >
> > Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> So you'd like to see the MIPS stuff cleaned up a bit more first before actual 
> sign-off?  Or just more testing?

I think it'd be *nice* if that MIPS stuff got cleaned up, but that's
way beyond my scope.  I just want to address Kyle's comments and make
sure I don't screw up ARM and PARISC.

Bjorn
