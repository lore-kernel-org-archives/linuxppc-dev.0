Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 17324B7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 13:03:01 +1100 (EST)
Date: Thu, 21 Jan 2010 18:03:11 -0800 (PST)
Message-Id: <20100121.180311.228791894.davem@davemloft.net>
To: wg@grandegger.com
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <4B5871F2.9090005@grandegger.com>
References: <1264039999-25731-3-git-send-email-agust@denx.de>
	<20100121.012235.161201297.davem@davemloft.net>
	<4B5871F2.9090005@grandegger.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	agust@denx.de, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 21 Jan 2010 16:25:38 +0100

> Do you see a more clever solution to this problem?

See how we handle this in the ESP scsi driver.  We have a set of
defines for the register offsets, and a set of methods a chip driver
implements for register accesses.

If the offsets differ, the register access method can translate the
generic register offsets into whatever layout their implementation
actually uses.

> Nevertheless, the code could be improved by using "offsetof", I
> think.

At a minimum :-)
