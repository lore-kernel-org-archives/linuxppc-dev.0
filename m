Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DFE91A01B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 22:34:41 +1000 (EST)
Message-ID: <53D6435D.6050601@suse.de>
Date: Mon, 28 Jul 2014 14:34:37 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Use the POWER8 Micro Partition Prefetch Engine
 in KVM HV
References: <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.07.14 06:18, Stewart Smith wrote:
> changes since v3:
> - use kvmppc namespace
> - MPP_BUFFER_ORDER of 3 not 4, as we only need 32k and it's already 32k aligned
> - split out kvmppc_vcore_create in separate patch
> - give a variable a better name: s/tmp/mpp_addr/
> - logmpp becomes static inline function
>
> Stewart Smith (2):
>    Split out struct kvmppc_vcore creation to separate function
>    Use the POWER8 Micro Partition Prefetch Engine in KVM HV on POWER8

I only realized just now that I've commented on v3 :). Sorry. I guess 
the name isn't really important enough for a respin. If you come up with 
a really nice one, I'd be happy to apply another patch that renames it.

Thanks, applied all to kvm-ppc-queue.


Alex
