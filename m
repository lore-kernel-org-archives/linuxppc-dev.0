Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3E258B7C7E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 00:58:45 +1100 (EST)
Received: from mgw-mx06.nokia.com (mgw-mx06.nokia.com [192.100.122.233])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	o2UDHiwb007669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 16:17:45 +0300
Subject: Re: [PATCH v3 04/11] mtd: Add MPC5121 NAND Flash Controller driver
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa41002091842g6795bf68lb8b410d433cd7f31@mail.gmail.com>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-5-git-send-email-agust@denx.de>
	<fa686aa41002091842g6795bf68lb8b410d433cd7f31@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Mar 2010 16:15:07 +0300
Message-ID: <1269954907.6648.9.camel@localhost>
Mime-Version: 1.0
Cc: Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Anatolij Gustschin <agust@denx.de>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-02-09 at 19:42 -0700, Grant Likely wrote:
> On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > Adds NAND Flash Controller driver for MPC5121 Revision 2.
> > All device features, except hardware ECC and power management,
> > are supported.
> >
> > Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> > Signed-off-by: Wolfgang Denk <wd@denx.de>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: <linux-mtd@lists.infradead.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: John Rigby <jcrigby@gmail.com>
> 
> On *very* brief review...
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> David, there are ordering issues on this patch with arch-specific
> code.  If the patch looks okay to you, then can I pick it up into my
> tree?

Because of the general large response time of the MTD community, I
suggest you to go put this stuff to your tree.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
