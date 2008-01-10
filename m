Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1D4EADE017
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 11:27:06 +1100 (EST)
Date: Wed, 9 Jan 2008 18:36:34 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20080110003634.GA19966@lixom.net>
References: <20080109190852.GA18827@localhost.localdomain>
	<20080109191041.GB23283@localhost.localdomain>
	<20080110104048.2fea6ab3.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080110104048.2fea6ab3.sfr@canb.auug.org.au>
Cc: Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2008 at 10:40:48AM +1100, Stephen Rothwell wrote:
> Hi Anton,
> 
> Juts one small trivial comment (could be fixed later).
> 
> On Wed, 9 Jan 2008 22:10:41 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +static struct of_device_id pata_of_platform_match[] = {
> 
> This could be declared const.

Good point, but let's not hold up merge based on this. Need something
for janitors to do too, and it's good enough to merge as-is. :)


-Olof
