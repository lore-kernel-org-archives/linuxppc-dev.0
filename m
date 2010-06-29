Return-Path: <davem@davemloft.net>
Date: Mon, 28 Jun 2010 20:11:18 -0700 (PDT)
Message-Id: <20100628.201118.260086239.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 3/5] sparc: turn CONFIG_OF into a select
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100629124450.5e85bafe.sfr@canb.auug.org.au>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
	<20100629124450.5e85bafe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, paulus@samba.org,
	sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 12:44:50 +1000

> so that we can make CONFIG_OF global and remove it from
> the architecture Kconfig files later.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
