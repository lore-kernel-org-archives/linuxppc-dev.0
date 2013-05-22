Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 050C22C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 03:25:41 +1000 (EST)
Date: Wed, 22 May 2013 10:59:08 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio
 device tree nodes
Message-ID: <20130522165908.GB12320@obsidianresearch.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130521174849.GL26249@lunn.ch> <519C9333.20609@gmail.com>
 <519C9822.9040909@windriver.com> <519C9A66.3050807@gmail.com>
 <20130522131010.GB31290@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130522131010.GB31290@titan.lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "tiejun.chen" <tiejun.chen@windriver.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 09:10:10AM -0400, Jason Cooper wrote:

> iirc, our solution to this was to parse the ATAGs for the mac addr and
> update the appended dtb.  This way, module load and unload would work
> without loosing the mac address.  I believe Jason Gunthorpe has a patch
> to atags_to_fdt() for this...  This should allow us to get rid of the
> clocks hack.

Sorry, no, we don't use ATAGs here, our platforms start the kernel
with a correct DTB that has the correct mac address to use. My patch
was to have the driver accept it, and I think Sebastian has already
got that functionality...

Jason
