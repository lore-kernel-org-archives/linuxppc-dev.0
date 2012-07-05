Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C44C2C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 21:49:15 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR
 support in sregs
Date: Thu, 5 Jul 2012 11:49:05 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15B220@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4E5FF9AC-1759-423F-A918-3BA0AEAE5349@suse.de>
In-Reply-To: <4E5FF9AC-1759-423F-A918-3BA0AEAE5349@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
> Sent: Wednesday, July 04, 2012 4:34 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR
> support in sregs
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
> > Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
> > for 64-bit hosts.
>=20
> Please also implement a ONE_REG interface while at it. Over time, I'd
> like to move towards ONE_REG instead of the messy regs/sregs API.

ONE_REG doesn't seem to be implemented at all for book3e, I looked at
kvm_vcpu_ioctl_set_one_reg/kvm_vcpu_ioctl_get_one_reg in booke.c file.

I can take care of it soon but in a different patch set. It's ok like this?

-Mike
