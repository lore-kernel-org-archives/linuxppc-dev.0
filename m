Return-Path: <OGabbay@advaoptical.com>
Received: from mail.advaoptical.com (mail.advaoptical.com [91.217.199.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "muc-vsrv-fsmail.advaoptical.com",
 Issuer "muc-vsrv-fsmail.advaoptical.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ADF392C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:10:05 +1000 (EST)
Message-ID: <51B8730F.2030606@advaoptical.com>
Date: Wed, 12 Jun 2013 16:09:35 +0300
From: Oded Gabbay <ogabbay@advaoptical.com>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] MDIO: FSL_PQ_MDIO: Fix bug on incorrect offset of tbipa
 register
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
 <51B871CB.1090808@tabi.org>
In-Reply-To: <51B871CB.1090808@tabi.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: stef.van.os@prodrive.nl, bigeasy@linutronix.de,
 Dongsheng.Wang@freescale.com, paulus@samba.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, B38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oded Gabbay wrote:
>> Note: This patch may break MDIO functionallity of some old 
>> Freescale's SoC
>> until Freescale will fix their device tree files. Basically, every 
>> device tree
>> which contains an mdio device that is compatible to "fsl,gianfar-tbi" 
>> should be
>> examined.
>
> On 06/12/2013 04:04 PM, Timur Tabi wrote:
> I haven't had a chance to review the patch in detail, but I can tell 
> you that breaking compatibility with older device trees is 
> unacceptable.  You need to add some code, even if it's an ugly hack, 
> to support those trees.
>
I generally agree with this statement except that without this patch, 
almost ALL of Freescale's SoC that uses "fsl,gianfar-tbi" are broken, 
including the older ones. At least this patch fixes some of the device 
trees. Because I'm not working at Freescale, I have a very limited 
access to a few SoC which I could test this patch on. I think it is 
Freescale's responsibility to release a complementary patch to fix the 
rest of the SoC device trees.

Oded
