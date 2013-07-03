Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D035E2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:55:50 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Date: Wed, 3 Jul 2013 13:55:43 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A38B0@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
In-Reply-To: <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Wednesday, July 03, 2013 4:45 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
>=20
>=20
> On 03.07.2013, at 14:42, Mihai Caraman wrote:
>=20
> > Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> > returning to guest instead of each sched in. Without this improvement
> > an interrupt may also claim floting point corrupting guest state.
>=20
> Not sure I follow. Could you please describe exactly what's happening?

This was already discussed on the list, I will forward you the thread.

-Mike
