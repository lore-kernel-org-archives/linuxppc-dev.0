Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 113BDB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:53:16 +1000 (EST)
Message-ID: <4C271F8A.5090903@redhat.com>
Date: Sun, 27 Jun 2010 12:53:14 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 09/26] KVM: PPC: Add PV guest scratch registers
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-10-git-send-email-agraf@suse.de>
	<4C270A34.4020706@redhat.com>
	<27BB673F-F34E-4CC6-A22D-02CF95E7529F@suse.de>
In-Reply-To: <27BB673F-F34E-4CC6-A22D-02CF95E7529F@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/27/2010 12:41 PM, Alexander Graf wrote:
>
> Am 27.06.2010 um 10:22 schrieb Avi Kivity <avi@redhat.com>:
>
>> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>>> While running in hooked code we need to store register contents out 
>>> because
>>> we must not clobber any registers.
>>>
>>> So let's add some fields to the shared page we can just happily 
>>> write to.
>>>
>>>
>>
>> How are these protected during interrupts?
>
> By the 'critical section' bit. When in a critical section (read: using 
> scratch registers), we don't issue interrupts.

Ok.  I thought you needed scratch registers to set up the critical 
section, but you don't.  Neat stuff.

-- 
error compiling committee.c: too many arguments to function
