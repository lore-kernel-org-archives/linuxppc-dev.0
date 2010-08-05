Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 106691007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 17:57:57 +1000 (EST)
Message-ID: <4C5A6F01.6050705@redhat.com>
Date: Thu, 05 Aug 2010 10:57:53 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
References: <1280407688-9815-1-git-send-email-agraf@suse.de>	<4C557E7A.3010606@redhat.com>	<C27A7E71-2F93-45D2-989D-0AB80D9C2C0B@suse.de>
	<20100803111611.38ca87e6@schlenkerla.am.freescale.net>
In-Reply-To: <20100803111611.38ca87e6@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Alexander Graf <agraf@suse.de>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 08/03/2010 07:16 PM, Scott Wood wrote:
> On Sun, 1 Aug 2010 22:21:37 +0200
> Alexander Graf<agraf@suse.de>  wrote:
>
>> On 01.08.2010, at 16:02, Avi Kivity wrote:
>>
>>> Looks reasonable.  Since it's fair to say I understand nothing about powerpc, I'd like someone who does to review it and ack, please, with an emphasis on the interfaces.
>> Sounds good. Preferably someone with access to the ePAPR spec :).
> The ePAPR-relevant stuff in patches 7, 16, and 17 looks reasonable.
> Did I miss any ePAPR-relevant stuff in the other patches?

Shall I take this as an ACK?

-- 
error compiling committee.c: too many arguments to function
