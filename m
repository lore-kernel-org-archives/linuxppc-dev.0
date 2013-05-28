Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42A0E2C032D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 08:52:50 +1000 (EST)
Date: Tue, 28 May 2013 17:52:09 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369137900-5748-2-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Tue May 21 07:04:58 2013)
Message-ID: <1369781529.18630.25@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> It also seems that we don't support ISA on all the current corenet ds
> boards. So picking a primary bus seems useless, remove that function
> too.

IIRC that was due to some bugs in the PPC PCI code in the absence of =20
any primary bus.  fsl_pci_assign_primary() will arbitrarily pick one to =20
be primary if there's no ISA.  Have the bugs been fixed?

-Scott=
