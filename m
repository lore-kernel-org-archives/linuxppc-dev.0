Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkyZw0693zDqxv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 21:05:12 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id dx3so4168637pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 04:05:11 -0700 (PDT)
Message-ID: <1467803125.9143.3.camel@gmail.com>
Subject: Re: [PATCH 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
From: Balbir Singh <bsingharora@gmail.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 kvm-ppc@vger.kernel.org,  qemu-devel@nongnu.org, paulus@samba.org,
 david@gibson.dropbear.id.au
Date: Wed, 06 Jul 2016 21:05:25 +1000
In-Reply-To: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
References: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-06 at 16:05 +1000, Sam Bobroff wrote:
> Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
> determine if a PowerPC KVM guest should use HTM (Hardware Transactional
> Memory).
> 
> This will be used by QEMU to populate the pa-features bits in the
> guest's device tree.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>

>  
