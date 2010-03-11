Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1CE99B8368
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:38:17 +1100 (EST)
Date: Thu, 11 Mar 2010 10:38:36 -0800 (PST)
Message-Id: <20100311.103836.13755632.davem@davemloft.net>
To: sshtylyov@mvista.com
Subject: Re: [PATCH 21/37] drivers/ata: use .dev.of_node instead of .node
	in struct of_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <4B9936F2.3020105@ru.mvista.com>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180543.4824.70491.stgit@angua>
	<4B9936F2.3020105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, linux-ide@vger.kernel.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com,
	sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
	jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	monstr@monstr.eu, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 11 Mar 2010 21:31:14 +0300

>   Should probably have been 2 patches instead of one, as drivers/ata/
>   and drivers/ide/ are different subsystems...

No, he should consolidate these changes _MORE_ not less.

The patch set is already too large to review at it is!
