Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 77C69B7F0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:23:28 +1100 (EST)
Date: Thu, 11 Mar 2010 10:23:47 -0800 (PST)
Message-Id: <20100311.102347.169562565.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 00/37] OF: move device node pointer into struct device.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100311.102043.40590962.davem@davemloft.net>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311.102043.40590962.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, broonie@opensource.wolfsonmicro.com,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, gregkh@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jeremy.kerr@canonical.com, linuxppc-dev@ozlabs.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	ben-linux@fluff.org, microblaze-uclinux@itee.uq.edu.au,
	sparclinux@vger.kernel.org, akpm@linux-foundation.org,
	alsa-devel@alsa-project.org, jgarzik@pobox.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 10:20:43 -0800 (PST)

> Three or four of the patches don't apply because only your tree
> has those "/* temporary */" comments, f.e. in arch/sparc/kernel/pci.c
> 
> I took care of this when applying to my tree.

It also doesn't build, what the heck is this against
Grant?

drivers/of/device.c: In function 'of_match_device':
drivers/of/device.c:24: error: 'const struct device' has no member named 'of_node'
drivers/of/device.c:26: error: 'const struct device' has no member named 'of_node'

Please make a patch set against Linus's vanilla tree so
I and others can test this.
