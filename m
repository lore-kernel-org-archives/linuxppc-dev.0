Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A0422C0201
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 22:12:37 +1000 (EST)
Message-ID: <4FF584AE.1080805@suse.de>
Date: Thu, 05 Jul 2012 14:12:30 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support
 in sregs
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4E5FF9AC-1759-423F-A918-3BA0AEAE5349@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B220@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15B220@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 07/05/2012 01:49 PM, Caraman Mihai Claudiu-B02008 wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Wednesday, July 04, 2012 4:34 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>> Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR
>> support in sregs
>>
>>
>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>
>>> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
>>> for 64-bit hosts.
>> Please also implement a ONE_REG interface while at it. Over time, I'd
>> like to move towards ONE_REG instead of the messy regs/sregs API.
> ONE_REG doesn't seem to be implemented at all for book3e, I looked at
> kvm_vcpu_ioctl_set_one_reg/kvm_vcpu_ioctl_get_one_reg in booke.c file.
>
> I can take care of it soon but in a different patch set. It's ok like this?

Do it in a different patch, but as part of this patch set.


Alex
