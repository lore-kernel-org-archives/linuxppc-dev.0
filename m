Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 03FC114008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 20:07:04 +1000 (EST)
Message-ID: <536B5743.2060708@suse.de>
Date: Thu, 08 May 2014 12:06:59 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5] KVM: PPC: BOOK3S: Use the saved dar value and generic
 make_dsisr
References: <1399386622-21407-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399386622-21407-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 04:30 PM, Aneesh Kumar K.V wrote:
> Although it's optional IBM POWER cpus always had DAR value set on
> alignment interrupt. So don't try to compute these values.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

The patch body is fine now. The commit message however is not. The patch 
does two things:

   * Merge DSISR calculation with Linux's implementation
   * Use the real DAR on book3s_64 alignment interrupts

In fact, you probably should make this 2 patches.


Alex
