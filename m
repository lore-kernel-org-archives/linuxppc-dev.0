Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 62EB467F67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 07:19:13 +1000 (EST)
Date: Tue, 16 Aug 2005 14:19:08 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Otto Solares <solca@guug.org>
Message-ID: <20050816141908.A1053@cox.net>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050816211259.GB28419@guug.org>;
	from solca@guug.org on Tue, Aug 16, 2005 at 03:12:59PM -0600
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

On Tue, Aug 16, 2005 at 03:12:59PM -0600, Otto Solares wrote:
> On Mon, Aug 15, 2005 at 10:25:10PM -0700, Matt Porter wrote:
> > On Thu, Aug 11, 2005 at 09:28:19PM -0600, Otto Solares wrote:
> > > Hi!
> > > 
> > > Redwood-6 support in 2.6 is broken.  I subscribed to this
> > > list just to know if somebody is working on it?  2.4.30
> > > works ok.
> > 
> > I went ahead and fixed this compile issue in the following patch:
> > http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019782.html
> 
> Excellent!, it compiles now.
> 
> Now, when 'make znetboot' in 2.4 there was a zImage.embedded, is the
> same thing as zImage.treebot that appears now in 2.6?

Yes, this is the image that boots on the stock OpenBIOS firmware.
It has the standard "tree" header on it.

-Matt
