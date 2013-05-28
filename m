Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6ECE82C0340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 09:35:26 +1000 (EST)
Date: Tue, 28 May 2013 18:35:15 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1369763138.18630.3@snotra> <51A53E20.3020205@ozlabs.ru>
In-Reply-To: <51A53E20.3020205@ozlabs.ru> (from aik@ozlabs.ru on Tue May 28
 18:30:40 2013)
Message-ID: <1369784115.18630.27@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/28/2013 06:30:40 PM, Alexey Kardashevskiy wrote:
> >> >>> @@ -939,6 +940,9 @@ struct kvm_s390_ucas_mapping {
> >> >>> #define KVM_GET_DEVICE_ATTR      _IOW(KVMIO,  0xe2, struct
> >> >>> kvm_device_attr)
> >> >>> #define KVM_HAS_DEVICE_ATTR      _IOW(KVMIO,  0xe3, struct
> >> >>> kvm_device_attr)
> >> >>>
> >> >>> +/* ioctl for SPAPR TCE IOMMU */
> >> >>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xe4, struct
> >> >>> kvm_create_spapr_tce_iommu)
> >> >>
> >> >> Shouldn't this go under the vm ioctl section?
> >>
> >>
> >> The KVM_CREATE_SPAPR_TCE_IOMMU ioctl (the version for emulated =20
> devices) is
> >> in this section so I decided to keep them together. Wrong?
> >
> > You decided to keep KVM_CREATE_SPAPR_TCE_IOMMU together with
> > KVM_CREATE_SPAPR_TCE_IOMMU?
>=20
> Yes.

Sigh.  That's the same thing repeated.  There's only one IOCTL.  =20
Nothing is being "kept together".

-Scott=
