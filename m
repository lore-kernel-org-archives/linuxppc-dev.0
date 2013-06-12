Return-Path: <timur@tabi.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 99D872C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:04:18 +1000 (EST)
Message-ID: <51B871CB.1090808@tabi.org>
Date: Wed, 12 Jun 2013 08:04:11 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Oded Gabbay <ogabbay@advaoptical.com>, benh@kernel.crashing.org,
 paulus@samba.org, leoli@freescale.com, galak@kernel.crashing.org,
 B38951@freescale.com, Dongsheng.Wang@freescale.com,
 bigeasy@linutronix.de, stef.van.os@prodrive.nl, davem@davemloft.net
Subject: Re: [PATCH] MDIO: FSL_PQ_MDIO: Fix bug on incorrect offset of tbipa
 register
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
In-Reply-To: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oded Gabbay wrote:
> Note: This patch may break MDIO functionallity of some old Freescale's SoC
> until Freescale will fix their device tree files. Basically, every device tree
> which contains an mdio device that is compatible to "fsl,gianfar-tbi" should be
> examined.

I haven't had a chance to review the patch in detail, but I can tell you 
that breaking compatibility with older device trees is unacceptable.  You 
need to add some code, even if it's an ugly hack, to support those trees.

-- 
Timur Tabi
