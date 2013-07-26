Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F34D2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 08:43:53 +1000 (EST)
Date: Fri, 26 Jul 2013 17:43:44 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
References: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com>
 <1374618676.15592.40@snotra>
 <20130725125453.GK5084@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130725125453.GK5084@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jul 25 07:54:53 2013)
Message-ID: <1374878624.30721.33@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 07:54:53 AM, Kevin Hao wrote:
> The reason is that the ppc kernel assume that the BARs starting
> at 0 is unset and will reassign it later. There is a bug in the =20
> previous
> kernel, so the kernel maybe not work well for qemu in this case. But I
> think this has been fixed by the commit c5df457f (powerpc/pci: Check =20
> the
> bus address instead of resource address in pcibios_fixup_resources).

What ensures that the reassignment will not assign zero?

I'm not doubting the result that it does, but I'm having a hard time =20
seeing it in the code.

Or are you saying that the resource assignment code will run twice, =20
rather than just saying that we won't trust the firmware when we find =20
zero?

-Scott=
