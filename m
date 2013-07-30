Return-Path: <B25806@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 677812C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 20:16:54 +1000 (EST)
Received: from mail80-db8 (localhost [127.0.0.1])	by mail80-db8-R.bigfish.com
 (Postfix) with ESMTP id EBB6BD60315	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 30 Jul 2013 10:16:48 +0000 (UTC)
Received: from DB8EHSMHS022.bigfish.com (unknown [10.174.8.246])	by
 mail80-db8.bigfish.com (Postfix) with ESMTP id 9ED73DA0149	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 10:16:46 +0000 (UTC)
Message-ID: <51F793D3.6080504@freescale.com>
Date: Tue, 30 Jul 2013 18:22:11 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc/85xx: Add P1023RDB board support
References: <1371198380-12792-1-git-send-email-Chunhe.Lan@freescale.com>
 <20130730010945.GA8645@home.buserror.net>
In-Reply-To: <20130730010945.GA8645@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07/30/2013 09:09 AM, Scott Wood wrote:
> On Fri, Jun 14, 2013 at 04:26:20PM +0800, Chunhe Lan wrote:
>> Ethernet:
>>     eTSEC1: Connected to Atheros AR8035 GETH PHY
>>     eTSEC2: Connected to Atheros AR8035 GETH PHY
> Where are the PHYs in the device tree?
     "Atheros AR8035 GETH PHY" driver is module_init driver. It uses the 
two structs of "static struct phy_driver at8035_driver" and
     "static struct mdio_device_id __maybe_unused atheros_tbl" to 
register at8035_driver.

     So do not need to add PHYs in the device tree.

Thanks,
-Chunhe
