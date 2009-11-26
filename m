Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 35C07B7BBB
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 00:20:13 +1100 (EST)
Message-ID: <4B0E8089.9030403@redhat.com>
Date: Thu, 26 Nov 2009 15:20:09 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259234174-1104-1-git-send-email-agraf@suse.de>
	<4B0E7738.5030506@redhat.com> <4B0E78BC.5050901@suse.de>
	<4B0E799C.80209@redhat.com> <4B0E7FC0.3000803@suse.de>
In-Reply-To: <4B0E7FC0.3000803@suse.de>
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

On 11/26/2009 03:16 PM, Alexander Graf wrote:
>
>> You can keep pvr out of the (named) union.
>>      
>
> So we'd have
>
> sregs.padded.ppc64.slb?
>
>    

or sregs.u.ppc64.slb.

> I don't see how that is an improvement.
>    

Buildability takes precedence.

(an alternative is to drop the union, and add a BUILD_BUG_ON(sizeof...)).

-- 
error compiling committee.c: too many arguments to function
