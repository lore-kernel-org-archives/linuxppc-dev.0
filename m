Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 08BC8B73E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:10:24 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-25-git-send-email-agraf@suse.de>
	<EDF0A567-C440-4F1B-9AF5-2E0F8203D566@kernel.crashing.org>
Message-Id: <05E77C6E-7465-4A0E-B00B-F1240417281D@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <EDF0A567-C440-4F1B-9AF5-2E0F8203D566@kernel.crashing.org>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 24/26] KVM: PPC: PV mtmsrd L=0 and mtmsr
Date: Sun, 27 Jun 2010 11:10:38 +0200
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


Am 26.06.2010 um 19:03 schrieb Segher Boessenkool <segher@kernel.crashing.org 
 >:

>> There is also a form of mtmsr where all bits need to be addressed.  
>> While the
>> PPC64 Linux kernel behaves resonably well here, the PPC32 one never  
>> uses the
>> L=1 form but does mtmsr even for simple things like only changing EE.
>
> You make it sound like the 32-bit kernel does something stupid, while
> there is no other choice.  The "L=1" thing only exists for 64-bit.

Oh, so that's why :). That doesn't really change the fact that it's  
very hard to distinguish between a mtmsr that only changes MSR_EE vs  
one that changes MSR_IR for example :).

Alex

>
