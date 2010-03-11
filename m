Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1B900B856B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:26:27 +1100 (EST)
Date: Thu, 11 Mar 2010 10:26:46 -0800 (PST)
Message-Id: <20100311.102646.06576136.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 00/27] Clean up of_platform drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
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


Grant you've just posted two enormous patch sets at the SAME EXACT
TIME to the SAME AREAS of the kernel.

One has 37 patches and this one has 27.

Not only are these sets enormous, you haven't specified what in the
world they are against.

The 37 patch set didn't apply cleanly to Linus tree and once I worked
through the rejects as best I could it didn't even compile.

How are people supposed to test this stuff? :-/
