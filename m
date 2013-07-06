Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE1342C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2013 02:18:07 +1000 (EST)
Date: Sat, 6 Jul 2013 12:17:43 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
Message-ID: <20130706161743.GM2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
 <20130706135433.GL2569@titan.lakedaemon.net>
 <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
Cc: Lior Amsalem <alior@marvell.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Rob Herring <rob.herring@calxeda.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 06, 2013 at 09:40:55AM -0600, Bjorn Helgaas wrote:
> On Sat, Jul 6, 2013 at 7:54 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
> >> Dear Bjorn Helgaas,
> >>
> >> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
> >>
> >> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> >
> >> > Again, please update the subject line to "PCI: Remove ..."
> >> >
> >> > I doubt that you'll get explicit acks from all the arches you touched,
> >> > but I think it's reasonable to put at least patches 2 & 3 in -next
> >> > soon after v3.11-rc1, so we should have time to shake out issues.
> >>
> >> Sure. Which merge strategy do you suggest for this patch series, which
> >> touches a number of different areas, and has some build-time
> >> dependencies between the patches (if needed, I can detail those build
> >> time dependencies to help figuring out the best strategy).
> >
> > If we end up handling this the same as the of/pci & mvebu-pcie series
> > (whole series through mvebu -> arm-soc) I can have it up in -next within
> > a few days of -rc1.  Just let me know.
> 
> That sounds fine with me.  I don't think it's worth trying to split
> out the drivers/pci stuff and trying to coordinate it going through
> different trees.

Ok, will do.

Thomas, I assume there will be one more version to address Bjorn's last
comments?

thx,

Jason.
