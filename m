Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C3183B6F0E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 00:16:50 +1100 (EST)
Message-ID: <4B0E7FC0.3000803@suse.de>
Date: Thu, 26 Nov 2009 14:16:48 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259234174-1104-1-git-send-email-agraf@suse.de>
	<4B0E7738.5030506@redhat.com> <4B0E78BC.5050901@suse.de>
	<4B0E799C.80209@redhat.com>
In-Reply-To: <4B0E799C.80209@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 11/26/2009 02:46 PM, Alexander Graf wrote:
>>
>>> Please avoid unnamed unions in user-visible headers - they're a gcc
>>> extension.
>>>
>>> Yes, we have them elsewhere, but let's not add to the pile.
>>>      
>> I'm open to scalable suggestions that don't break existing userspace
>> code.
>> If I name the union now, existing qemu code will break. If I align the
>> pad array manually I'll definitely mess up something.
>>    
>
> You can keep pvr out of the (named) union.


So we'd have

sregs.padded.ppc64.slb?

I don't see how that is an improvement.


Alex
