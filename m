Return-Path: <solca@guug.org>
Received: from guug.org (guug.org [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id B8D4367F67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 07:13:12 +1000 (EST)
Date: Tue, 16 Aug 2005 15:12:59 -0600
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050816211259.GB28419@guug.org>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050815222510.C28706@cox.net>
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

On Mon, Aug 15, 2005 at 10:25:10PM -0700, Matt Porter wrote:
> On Thu, Aug 11, 2005 at 09:28:19PM -0600, Otto Solares wrote:
> > Hi!
> > 
> > Redwood-6 support in 2.6 is broken.  I subscribed to this
> > list just to know if somebody is working on it?  2.4.30
> > works ok.
> 
> I went ahead and fixed this compile issue in the following patch:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019782.html

Excellent!, it compiles now.

Now, when 'make znetboot' in 2.4 there was a zImage.embedded, is the
same thing as zImage.treebot that appears now in 2.6?

Thank you.

-otto
