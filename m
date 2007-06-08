Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D882DDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 22:42:50 +1000 (EST)
In-Reply-To: <1181292534.11341.9.camel@mark>
References: <1181292534.11341.9.camel@mark>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A3A9AE86-AE63-4341-88FF-6509E21AAAE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/6] 82xx: Add the support of Wind River SBC PowerQUICCII
	82xx
Date: Fri, 8 Jun 2007 07:43:08 -0500
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 8, 2007, at 3:48 AM, Mark Zhan wrote:

> Current MII bitbang bus driver hard-codes the phy mask of mii_bus to
> ~0x09, which is actually specific for the FSL boards. This patch will
> make the bitbang driver to generate MII bus phy_mask dynamically.

Your patch subject's should be unique in a patch series, they all  
shouldn't be 'add support for ...'

Also, this patch should be going via netdev and probably CC'd to  
Vitaly Bordug.

- k
