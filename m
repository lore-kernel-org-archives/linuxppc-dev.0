Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28671B7B9F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 04:53:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nA5HrS8R011680
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 10:53:28 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nA5Hub11015120
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:56:38 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH RFC] gianfar: Do not call skb recycling with disabled IRQs
Date: Thu, 5 Nov 2009 23:23:23 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81B950715@zin33exm22.fsl.freescale.net>
In-Reply-To: <E1N66Jp-0004Y0-8Q@jdl.com>
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<E1N62ti-0003iS-K2@jdl.com>
	<20091105142028.GB17171@oksana.dev.rtsoft.ru>
	<E1N63WM-0003xK-PN@jdl.com> <E1N64UY-00049g-Hb@jdl.com>
	<20091105165738.GA31923@oksana.dev.rtsoft.ru>
	<9F4C7D19E8361D4C94921B95BE08B81B950713@zin33exm22.fsl.freescale.net>
	<E1N66Jp-0004Y0-8Q@jdl.com>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: "Jon Loeliger" <jdl@jdl.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Fleming Andy-AFLEMING <afleming@freescale.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>
>Similar but different question:  What version is this patch based upon?
>I can't find:
>
>    > >index 197b358..a0ae604 100644
>
>My search of 2.6.31 up through current linux head=20
>(v2.6.32-rc6-26-g91d3f9b) and benh's current head=20
>(94a8d5caba74211ec76dac80fc6e2d5c391530df) do not have a=20
>version of this code with separate txqueues.
>
>I confess I'm not too familiar with the history here, so I=20
>don't know if that feature is in flux, or came, or went, or what.
>
>That boils down to:  I can't directly apply your patch, but I=20
>could hand-fudge its intent, but only on a single tx queue variant.
>

You might want to get the code base from the top of davem/net-next-2.6
tree

git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.git

The multi queue is a feature available in etsec2.0 version. On older
versions you might want to=20
work in a single queue mode itself.


--

Thanks
Sandeep
