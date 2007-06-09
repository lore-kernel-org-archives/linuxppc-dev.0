Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5E865DDEF1
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 01:27:20 +1000 (EST)
Date: Sat, 9 Jun 2007 19:08:47 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH 1/6] 82xx: Add the support of Wind River SBC
	PowerQUICCII 82xx
Message-ID: <20070609190847.1eb18d80@vitb.ru.mvista.com>
In-Reply-To: <1181292534.11341.9.camel@mark>
References: <1181292534.11341.9.camel@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 08 Jun 2007 16:48:53 +0800
Mark Zhan <rongkai.zhan@windriver.com> wrote:

> Current MII bitbang bus driver hard-codes the phy mask of mii_bus to
> ~0x09, which is actually specific for the FSL boards. This patch will
> make the bitbang driver to generate MII bus phy_mask dynamically.
> 
Please send this to netdev, CC me.

Of course since subject goes into SCM, it should be individual
and reflect briefly the nature of the specific change.


> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
> ---

-- 
Sincerely, 
Vitaly
