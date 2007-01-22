Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 827BEDDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 06:52:57 +1100 (EST)
Subject: Re: kernel 2.6.18: Confusion about Macintosh backlight configuration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Grimm <matthiasgrimm@users.sourceforge.net>
In-Reply-To: <20070122160518.2c2275bf.matthiasgrimm@users.sourceforge.net>
References: <20070120150614.0b62a3ef.matthiasgrimm@users.sourceforge.net>
	<1169436815.31479.4.camel@localhost.localdomain>
	<20070122160518.2c2275bf.matthiasgrimm@users.sourceforge.net>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 06:52:40 +1100
Message-Id: <1169495560.1582.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, 407671@bugs.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-22 at 16:05 +0100, Matthias Grimm wrote:
> On Mon, 22 Jan 2007 14:33:35 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > Which solution you prefer is up to you but I would be glad if at least
> > > solution #1 could be realised.
> > 
> > For now, at least, what prevents you from having all enabled and have
> > pbbuttonsd still call PMU_IOC_GRAB_BACKLIGHT ?
> 
> Nothing. Pbbuttonsd does so by now but this wouldn't help if someone set
> CONFIG_PMAC_BACKLIGHT_LEGACY to off. 
> 
> I check this out with debian, hoping you will find a smart solution for
> this in the future. I think the debian people getting aware of this
> backwards compatibility problem now and there is hope they will fix it
> for etch.

Yes, debian should keep CONFIG_PMAC_BACKLIGHT_LEGACY enabled.

Ben.
