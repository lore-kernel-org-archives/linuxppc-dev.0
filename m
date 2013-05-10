Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29C422C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 05:23:32 +1000 (EST)
Date: Fri, 10 May 2013 14:22:37 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <F4F07A17-8E1E-433D-9749-68D1495C42A7@suse.de> (from
 agraf@suse.de on Fri May 10 12:57:33 2013)
Message-ID: <1368213757.19683.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2013 12:57:33 PM, Alexander Graf wrote:
> Could you guys please collect performance data during the next weeks =20
> on both guest-directed ISIs as well as VF MMIOs (preferably with =20
> in-kernel MMIO), so that we can decide on the direction that's worth =20
> going towards?

Collecting data on VF MMIO would require implementing it (or at least =20
salvaging and fixing some old code), which is not a high priority at =20
the moment.  If we do implement VF in the future we could always undo =20
the direct ISI change, but it would still be nice to know if there's =20
any real benefit in the first place.

FWIW, I doubt that the "more stress on HW TLB" will be significant.

-Scott=
