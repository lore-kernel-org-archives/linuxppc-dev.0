Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5700A2C0343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 10:12:41 +1000 (EST)
Received: by mail-pa0-f49.google.com with SMTP id bi5so8505593pad.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 17:12:39 -0700 (PDT)
Message-ID: <51A547F0.8090406@ozlabs.ru>
Date: Wed, 29 May 2013 10:12:32 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1369763138.18630.3@snotra> <51A53E20.3020205@ozlabs.ru>
 <1369784115.18630.27@snotra>
In-Reply-To: <1369784115.18630.27@snotra>
Content-Type: text/plain; charset=KOI8-R
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

On 05/29/2013 09:35 AM, Scott Wood wrote:
> On 05/28/2013 06:30:40 PM, Alexey Kardashevskiy wrote:
>> >> >>> @@ -939,6 +940,9 @@ struct kvm_s390_ucas_mapping {
>> >> >>> #define KVM_GET_DEVICE_ATTR      _IOW(KVMIO,  0xe2, struct
>> >> >>> kvm_device_attr)
>> >> >>> #define KVM_HAS_DEVICE_ATTR      _IOW(KVMIO,  0xe3, struct
>> >> >>> kvm_device_attr)
>> >> >>>
>> >> >>> +/* ioctl for SPAPR TCE IOMMU */
>> >> >>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xe4, struct
>> >> >>> kvm_create_spapr_tce_iommu)
>> >> >>
>> >> >> Shouldn't this go under the vm ioctl section?
>> >>
>> >>
>> >> The KVM_CREATE_SPAPR_TCE_IOMMU ioctl (the version for emulated
>> devices) is
>> >> in this section so I decided to keep them together. Wrong?
>> >
>> > You decided to keep KVM_CREATE_SPAPR_TCE_IOMMU together with
>> > KVM_CREATE_SPAPR_TCE_IOMMU?
>>
>> Yes.
> 
> Sigh.  That's the same thing repeated.  There's only one IOCTL.  Nothing is
> being "kept together".

Sorry, I meant this ioctl - KVM_CREATE_SPAPR_TCE.


-- 
Alexey
