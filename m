Return-Path: <B02008@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBB592C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 04:22:05 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 15/17] KVM: PPC64: bookehv: Add support
 for interrupt handling
Date: Wed, 4 Jul 2012 18:21:52 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15A887@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-16-git-send-email-mihai.caraman@freescale.com>
 <FB7DFF5C-5E14-4202-9180-7968294F6A56@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15A6E8@039-SN2MPN1-013.039d.mgd.msft.net>,
 <5C22DF4D-4F41-4A25-9E01-C69CF02B0C52@suse.de>
In-Reply-To: <5C22DF4D-4F41-4A25-9E01-C69CF02B0C52@suse.de>
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

>On 04.07.2012, at 17:37, Caraman Mihai Claudiu-B02008 wrote:=0A=
>=0A=
>>> -----Original Message-----=0A=
>>> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-=0A=
>>> owner@vger.kernel.org] On Behalf Of Alexander Graf=0A=
>>> Sent: Wednesday, July 04, 2012 6:14 PM=0A=
>>> To: Caraman Mihai Claudiu-B02008=0A=
>>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-=0A=
>>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org=0A=
>>> Subject: Re: [Qemu-ppc] [RFC PATCH 15/17] KVM: PPC64: bookehv: Add=0A=
>>> support for interrupt handling=0A=
>>>=0A=
>>> Is this code so vastly different from the 32bit variant that they can't=
=0A=
>>> be the same with a few simple ifdef's here and there?=0A=
>>=0A=
>> As you can see from input register values things are quite different. I =
strived=0A=
>> to keep the code common, the only divergence is in the kvm_handler defin=
itions.=0A=
>=0A=
>What a shame :(. A lot of it looks very very similar.=0A=
=0A=
The Devil is in the details ;)=0A=
=0A=
-Mike=
