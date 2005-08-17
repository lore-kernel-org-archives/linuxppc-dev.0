Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 9548467FC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 05:18:18 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 17 Aug 2005 12:18:15 -0700
To: Otto Solares <solca@guug.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050817191815.GA331@xyzzy.farnsworth.org>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org> <20050816141908.A1053@cox.net>
	<20050817024745.GA30824@guug.org>
	<20050817031336.GA20712@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050817031336.GA20712@xyzzy.farnsworth.org>
Subject: Re: Redwood-6 and 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 03:13:36AM +0000, Dale Farnsworth wrote:
> I added smc91111 support for redwood5 and redwood6 many months
> ago.  See the reference to CONFIG_REDWOOD_5 in smc91x.h.  I haven't
> tested it recently though.  I'll give it a try tomorrow.

Just following up.  I verified that current linux-2.6.git netboots
fine on redwood5 using the SMC91111.

-Dale
