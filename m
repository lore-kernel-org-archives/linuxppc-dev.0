Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 62999B7BCB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 23:50:41 +1100 (EST)
Message-ID: <4B0E799C.80209@redhat.com>
Date: Thu, 26 Nov 2009 14:50:36 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259234174-1104-1-git-send-email-agraf@suse.de>
	<4B0E7738.5030506@redhat.com> <4B0E78BC.5050901@suse.de>
In-Reply-To: <4B0E78BC.5050901@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/26/2009 02:46 PM, Alexander Graf wrote:
>
>> Please avoid unnamed unions in user-visible headers - they're a gcc
>> extension.
>>
>> Yes, we have them elsewhere, but let's not add to the pile.
>>      
> I'm open to scalable suggestions that don't break existing userspace code.
> If I name the union now, existing qemu code will break. If I align the
> pad array manually I'll definitely mess up something.
>    

You can keep pvr out of the (named) union.

-- 
error compiling committee.c: too many arguments to function
