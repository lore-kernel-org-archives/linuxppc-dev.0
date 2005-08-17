Return-Path: <solca@guug.org>
Received: from guug.org (guug.galileo.edu [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id 72F0D67EEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 12:47:51 +1000 (EST)
Date: Tue, 16 Aug 2005 20:47:45 -0600
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050817024745.GA30824@guug.org>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org> <20050816141908.A1053@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050816141908.A1053@cox.net>
From: Otto Solares <solca@guug.org>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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

On Tue, Aug 16, 2005 at 02:19:08PM -0700, Matt Porter wrote:
> On Tue, Aug 16, 2005 at 03:12:59PM -0600, Otto Solares wrote:
> > Now, when 'make znetboot' in 2.4 there was a zImage.embedded, is the
> > same thing as zImage.treebot that appears now in 2.6?
> 
> Yes, this is the image that boots on the stock OpenBIOS firmware.
> It has the standard "tree" header on it.

Thank you, just one more thing, do you know if the smc91x driver
works for PPC?  In 2.4 I had to set:

CONFIG_SMC91111=y
CONFIG_SMC91111_ADVANCED=y
CONFIG_SMC91111_BYTE_SWAP=y

Looking in the driver itself I think it was developed for ARM.

I am unable to netboot, I don't have serial console so my only access
to this little box (MediaMVP) is the net.  Thank you.

-otto
