Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 41119B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 22:05:34 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
	<4C2709F4.10805@redhat.com>
	<77DBE095-884F-4986-BE2B-15B2EEAD8CAC@suse.de>
	<4C271F5A.1030409@redhat.com>
	<DFC77851-3BE7-4746-93DE-287D5E27EF7D@suse.de>
	<4C272F08.8090709@redhat.com>
	<C90A3ABA-60E4-48D4-8332-3B49F3554447@suse.de>
	<4C273BAD.2090305@redhat.com>
Message-Id: <CF78C6B8-F600-4781-82CA-27865F745A60@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C273BAD.2090305@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
Date: Sun, 27 Jun 2010 14:06:01 +0200
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 27.06.2010 um 13:53 schrieb Avi Kivity <avi@redhat.com>:

> On 06/27/2010 02:49 PM, Alexander Graf wrote:
>>
>> Am 27.06.2010 um 12:59 schrieb Avi Kivity <avi@redhat.com>:
>>
>>> On 06/27/2010 01:33 PM, Alexander Graf wrote:
>>>>> Or inc/dec...
>>>>
>>>>
>>>> Uh - huh? How would that help?
>>>
>>> inc shared->critical   # disable interrupts
>>
>> There is no opcode in the ppc isa that acts on momery without  
>> involving a register.
>>
>> An inc would be:
>>
>> ld rX, A(0)
>> addi rX, rX, 1
>> std rX, A(0)
>
> Right, I was agreeing with you.  I meant there was no inc/dec mem  
> insns.

Ah, I see :). I think that's really the only point where I deem the  
x86 isa superior :).

Alex
