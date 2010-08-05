Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id E2BE31007E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 18:01:54 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C5A6F01.6050705@redhat.com>
Date: Thu, 5 Aug 2010 10:01:50 +0200
Message-Id: <55AD06CD-842E-49DC-97CD-AEE401F5B8C5@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>	<4C557E7A.3010606@redhat.com>	<C27A7E71-2F93-45D2-989D-0AB80D9C2C0B@suse.de>
	<20100803111611.38ca87e6@schlenkerla.am.freescale.net>
	<4C5A6F01.6050705@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	kvm-ppc@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.08.2010, at 09:57, Avi Kivity wrote:

> On 08/03/2010 07:16 PM, Scott Wood wrote:
>> On Sun, 1 Aug 2010 22:21:37 +0200
>> Alexander Graf<agraf@suse.de>  wrote:
>>=20
>>> On 01.08.2010, at 16:02, Avi Kivity wrote:
>>>=20
>>>> Looks reasonable.  Since it's fair to say I understand nothing =
about powerpc, I'd like someone who does to review it and ack, please, =
with an emphasis on the interfaces.
>>> Sounds good. Preferably someone with access to the ePAPR spec :).
>> The ePAPR-relevant stuff in patches 7, 16, and 17 looks reasonable.
>> Did I miss any ePAPR-relevant stuff in the other patches?
>=20
> Shall I take this as an ACK?

Hollis wanted to take a look at it too. But given the fact that I have =
another ~10 patches lying here I'd appreciate if things could get =
committed. If changes are so dramatic that they'd render things =
incompatible, we can always just release both patches for an actual =
kernel release, right?


Alex
