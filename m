Return-Path: <davem@davemloft.net>
Date: Tue, 24 Nov 2009 13:10:41 -0800 (PST)
Message-Id: <20091124.131041.207397574.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40911241233k7c6d428g8f70f00abdd754e8@mail.gmail.com>
References: <20091124081957.6216.74456.stgit@angua>
	<20091124.093732.203692950.davem@davemloft.net>
	<fa686aa40911241233k7c6d428g8f70f00abdd754e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 13:33:22 -0700

> If you prefer, I can change it all to simply '.phandle'.

Please do.
