Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E633C2C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 12:11:18 +1100 (EST)
Message-ID: <1360631461.4852.20.camel@smoke>
Subject: Re: Re[3]: PS3 platform is broken on Linux 3.7.0
From: Geoff Levand <geoff@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 17:11:01 -0800
In-Reply-To: <87zjzb4051.fsf@linux.vnet.ibm.com>
References: <1355488506.55692113@f147.mail.ru>
 <1358206641.4489.8.camel@smoke> <1360486777.923599245@f85.mail.ru>
 <1360487778.293641922@f350.mail.ru> <87k3qg4092.fsf@linux.vnet.ibm.com>
 <87zjzb4051.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Phileas Fogg <phileas-fogg@mail.ru>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On Mon, 2013-02-11 at 15:56 +0530, Aneesh Kumar K.V wrote:
> Can you try this patch ?
> 
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h

I tried your patch on PS3 with a ps3_defconfig build on both Linux-3.7
and Linux-3.8-rc7 and it seems to be working OK.

Please try to prepare a final fix for v3.8 and also send to linux-stable
for v3.7.

Thanks!

-Geoff
