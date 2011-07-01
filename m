Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 38FEFB6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 03:13:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Tabi Timur-B04825" <B04825@freescale.com>
Subject: Re: [PATCH 7/7] [v6] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Fri, 1 Jul 2011 19:12:49 +0200
References: <1307652726-4356-1-git-send-email-timur@freescale.com>
	<201106092304.55479.arnd@arndb.de>
	<BANLkTi=3r=UQYJVqRLRe-eu7rdkXQS-ESQ@mail.gmail.com>
In-Reply-To: <BANLkTi=3r=UQYJVqRLRe-eu7rdkXQS-ESQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107011912.50119.arnd@arndb.de>
Cc: "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cmetcalf@tilera.com" <cmetcalf@tilera.com>,
	"akpm@kernel.org" <akpm@kernel.org>,
	"dsaxena@linaro.org" <dsaxena@linaro.org>,
	"linux-console@vger.kernel.org" <linux-console@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 July 2011, Tabi Timur-B04825 wrote:
> On Thu, Jun 9, 2011 at 4:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 09 June 2011 22:52:06 Timur Tabi wrote:
> >> Add the drivers/virt directory, which houses drivers that support
> >> virtualization environments, and add the Freescale hypervisor management
> >> driver.
> ....
> >>
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> So I've made the changes that people have asked for, and Arnd has
> acked this driver.  Who's going to pick it up?  Who will be the
> maintainer for drivers/virt?  I'd really like to see this driver in
> 3.1, and there's not much time left.
> 
I'd say merge it  through the powerpc tree, and list yourself for
the driver, but not the entire directory.

	Arnd
