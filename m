Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D88692C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:00:18 +1100 (EST)
Date: Mon, 21 Jan 2013 19:59:55 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/mpic: make distribute_irqs obey
 MPIC_SINGLE_DEST_CPU
To: Scott Wood <scottwood@freescale.com>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
 <1358819804-28665-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1358819804-28665-2-git-send-email-scottwood@freescale.com>
 (from scottwood@freescale.com on Mon Jan 21 19:56:42 2013)
Message-ID: <1358819995.31204.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/21/2013 07:56:42 PM, Scott Wood wrote:
> Previously we were setting an illegal configuration on mpc85xx
> MPICs if CONFIG_IRQ_ALL_CPUS is enabled (which for some reason it is
> in mpc85xx_smp_defconfig).
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Sigh, please ignore the repost of this and the CONFIG_IRQ_ALL_CPUs =20
patch -- there were some leftover patches in my directory that I didn't =20
notice when running git send-email to send the coreint patches.

Don't ignore the original posting of these patches, though. :-)

-Scott=
