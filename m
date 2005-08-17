Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id B94D767F79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 13:13:39 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 16 Aug 2005 20:13:36 -0700
To: Otto Solares <solca@guug.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050817031336.GA20712@xyzzy.farnsworth.org>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org> <20050816141908.A1053@cox.net>
	<20050817024745.GA30824@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050817024745.GA30824@guug.org>
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

On Wed, Aug 17, 2005 at 02:47:45AM +0000, Otto Solares wrote:
> On Tue, Aug 16, 2005 at 02:19:08PM -0700, Matt Porter wrote:
> > On Tue, Aug 16, 2005 at 03:12:59PM -0600, Otto Solares wrote:
> > > Now, when 'make znetboot' in 2.4 there was a zImage.embedded, is the
> > > same thing as zImage.treebot that appears now in 2.6?
> > 
> > Yes, this is the image that boots on the stock OpenBIOS firmware.
> > It has the standard "tree" header on it.
> 
> Thank you, just one more thing, do you know if the smc91x driver
> works for PPC?

I added smc91111 support for redwood5 and redwood6 many months
ago.  See the reference to CONFIG_REDWOOD_5 in smc91x.h.  I haven't
tested it recently though.  I'll give it a try tomorrow.

If your machine is not a redwood5 or redwood6, you'll also have to
add platform device initialization in your platform code.  See
arch/ppc/platforms/4xx/redwood6.c.

-Dale
