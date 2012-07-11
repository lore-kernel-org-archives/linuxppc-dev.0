Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 89B712C0205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 04:08:06 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support
 in sregs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15B38A@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 11 Jul 2012 20:07:59 +0200
Message-Id: <DD01E87E-EC30-490A-9F82-8EFC2BD30690@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4E5FF9AC-1759-423F-A918-3BA0AEAE5349@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B220@039-SN2MPN1-013.039d.mgd.msft.net>
 <4FF584AE.1080805@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B38A@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
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


On 05.07.2012, at 14:54, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, July 05, 2012 3:13 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>> Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR
>> support in sregs
>>=20
>> On 07/05/2012 01:49 PM, Caraman Mihai Claudiu-B02008 wrote:
>>>> -----Original Message-----
>>>> From: Alexander Graf [mailto:agraf@suse.de]
>>>> Sent: Wednesday, July 04, 2012 4:34 PM
>>>> To: Caraman Mihai Claudiu-B02008
>>>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>>>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>>>> Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add =
EPCR
>>>> support in sregs
>>>>=20
>>>>=20
>>>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>>>=20
>>>>> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
>>>>> for 64-bit hosts.
>>>> Please also implement a ONE_REG interface while at it. Over time, =
I'd
>>>> like to move towards ONE_REG instead of the messy regs/sregs API.
>>> ONE_REG doesn't seem to be implemented at all for book3e, I looked =
at
>>> kvm_vcpu_ioctl_set_one_reg/kvm_vcpu_ioctl_get_one_reg in booke.c =
file.
>>>=20
>>> I can take care of it soon but in a different patch set. It's ok =
like
>> this?
>>=20
>> Do it in a different patch, but as part of this patch set.
>=20
> Hmm ... then if you don't disagree I will do it as a prerequisite =
patch since I want
> to keep this patchset strictly for 64-bit support.

I don't understand? You just make the same functionality available =
through 2 interfaces to user space.

> I am not familiar with ONE_REG, is qemu tailored to use it? I need a =
way to test it.

ONE_REG is just a more extensible ioctl. Just read up on it in the =
documentation and you'll see what I mean :)


Alex
