Return-Path: <BATV+b9b5b997e1b0c89ea184+2113+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E718AB70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 17:25:21 +1000 (EST)
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
From: David Woodhouse <dwmw2@infradead.org>
To: dedekind@infradead.org
In-Reply-To: <1239956778.3390.262.camel@localhost.localdomain>
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
	<200904161537.59048.sr@denx.de>
	<fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
	<1239889899.3390.216.camel@localhost.localdomain>
	<alpine.LFD.2.00.0904161936090.12608@baythorne.infradead.org>
	<1239956778.3390.262.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 06 Jun 2009 08:25:12 +0100
Message-Id: <1244273112.3751.1030.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-mtd@lists.infradead.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 11:26 +0300, Artem Bityutskiy wrote:
> 
> I'm going to try to help you. I've just created a git tree where
> I'll push patches I consider OK and I approve. Here it is:
> git://git.infradead.org/users/dedekind/l2-mtd-2.6.git
> 
> My hope is that you would look at that tree from time to time
> and pull it. At least you may be sure I looked at the patches and
> did some validation. This should save your time and help MTD
> users.

This was _really_ useful. Thank you very much.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
