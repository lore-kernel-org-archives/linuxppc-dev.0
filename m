Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CCF6B703B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 20:25:00 +1000 (EST)
Subject: Re: [PATCH v4] KVM: PPC Use clockevent multiplier and shifter for
 decrementer
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1334764879-18020-1-git-send-email-bharat.bhushan@freescale.com>
Date: Fri, 20 Apr 2012 12:24:54 +0200
Message-Id: <F72D662F-4842-4CB3-841A-054DDCB1C360@suse.de>
References: <1334764879-18020-1-git-send-email-bharat.bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 bharatb.yadav@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.04.2012, at 18:01, Bharat Bhushan wrote:

> Time for which the hrtimer is started for decrementer emulation is =
calculated using tb_ticks_per_usec. While hrtimer uses the clockevent =
for DEC reprogramming (if needed) and which calculate timebase ticks =
using the multiplier and shifter mechanism implemented within clockevent =
layer. It was observed that this conversion (timebase->time->timebase) =
are not correct because the mechanism are not consistent. In our setup =
it adds 2% jitter.
>=20
> With this patch clockevent multiplier and shifter mechanism are used =
when starting hrtimer for decrementer emulation. Now the jitter is < =
0.5%.
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>

Thanks, applied to kvm-ppc-next with fixed commit message and fixed =
trailing whitespace :).


Alex
