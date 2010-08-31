Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 21B3DB7134
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 16:28:35 +1000 (EST)
Message-ID: <4C7CA10E.1090505@redhat.com>
Date: Tue, 31 Aug 2010 09:28:30 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/26] KVM: PPC: Add feature bitmap for magic page
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
	<1282053481-18787-14-git-send-email-agraf@suse.de>
	<4C715382.6050809@redhat.com>
	<FAAE3BB9-E58E-4319-903A-B6C25D88D0E3@suse.de>
In-Reply-To: <FAAE3BB9-E58E-4319-903A-B6C25D88D0E3@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 08/31/2010 03:56 AM, Alexander Graf wrote:
> On 22.08.2010, at 18:42, Avi Kivity wrote:
>
>> On 08/17/2010 04:57 PM, Alexander Graf wrote:
>>> We will soon add SR PV support to the shared page, so we need some
>>> infrastructure that allows the guest to query for features KVM exports.
>>>
>>> This patch adds a second return value to the magic mapping that
>>> indicated to the guest which features are available.
>>>
>> You need to make that feature controllable from userspace, to allow new->old save/restore.
> Good one :). We're still missing too much stuff to even run without losing interrupts yet and you're thinking about new->old save/restore. Who'd want to migrate onto a system that's broken anyways? Besides - we're missing too many register values from the kernel side to even be able to perform a migration.
>
> I'm planning to add migration, probably after SMP. But that will be another CAP and anything before that won't be able to save/restore.

I'm thinking stability and basic functionality and your running around 
adding features (or new archs, depending on mood).  But I agree, this 
can wait until after SMP.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
