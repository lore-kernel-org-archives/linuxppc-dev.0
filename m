Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1FD42C0200
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 04:15:50 +1000 (EST)
Message-ID: <4FFC7139.3080303@freescale.com>
Date: Tue, 10 Jul 2012 13:15:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on
 core1 of AMP boot issue
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1341900506-23401-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 01:08 AM, Jia Hongtao wrote:
> The issue log on core1 is:
> root@mpc8572ds:~# ifconfig eth0 10.192.208.244
> net eth0: could not attach to PHY
> SIOCSIFFLAGS: No such device
> 
> To attach PHY node mdio@24520 should not be disabled in dts of core1.
> Because all PHYs are controlled through this node as follows:

So you grant it to both partitions?  How do you deal with synchronization?

-Scott
