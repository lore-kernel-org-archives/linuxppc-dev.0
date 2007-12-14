Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03EC6DE0F0
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 03:10:10 +1100 (EST)
Date: Fri, 14 Dec 2007 10:09:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071214160928.GA16607@ld0162-tx32.am.freescale.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
	<20071204200121.GA6782@lixom.net>
	<20071205004841.GA25905@linux-sh.org>
	<20071205183912.GA4516@loki.buserror.net>
	<20071214082313.GA28118@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214082313.GA28118@lixom.net>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 02:23:13AM -0600, Olof Johansson wrote:
> On Wed, Dec 05, 2007 at 12:39:12PM -0600, Scott Wood wrote:
> > Why is it dependent on anything other than platform bus support and ATA?
> 
> There's no way to specify dependency on platform bus as a config option,
> that's likely what EMBEDDED was meant to do. Some platforms have platform
> bus in spite of being !EMBEDDED, arch/arm/configs/rpc_defconfig seems
> to be among those. PPC too.

If platform bus can't be configged out, then the only dependency should
be the implicit one on ATA (is there anything else whose absence will
stop the code from building, or working if the appropriate platform
device is passed in?).

-Scott
