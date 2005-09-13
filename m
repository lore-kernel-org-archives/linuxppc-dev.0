Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 20E1068274
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2005 06:02:00 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 13 Sep 2005 13:01:57 -0700
To: linuxppc-dev@ozlabs.org
Message-ID: <20050913200157.GA1731@xyzzy.farnsworth.org>
References: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
	<20050913094045.301A31C00087@mwinf1104.wanadoo.fr>
	<20050913103539.GA17855@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050913103539.GA17855@lst.de>
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2005 at 10:35:39AM +0000, Christoph Hellwig wrote:
> anywya, I think the patch discussion is rather offtopic here.  Network
> driver patches are discussed and reviewed at netdev@oss.sgi.com

The current address is netdev@vger.kernel.org

I responded privately to Nicolas' message (before I realized it was posted
here).  Still, I think it worth mentioning that a workaround for the
mv643xx_eth TCP/UDP hw checksum issue is already in 2.6.14-rc1.

-Dale
