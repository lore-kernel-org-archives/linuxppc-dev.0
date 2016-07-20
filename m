Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvNxC6X0pzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 14:20:15 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so2497434pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 21:20:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org, paulus@samba.org,
 david@gibson.dropbear.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <218cd770-4be8-60e0-829a-d811eae6c453@gmail.com>
Date: Wed, 20 Jul 2016 14:20:02 +1000
MIME-Version: 1.0
In-Reply-To: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/07/16 13:41, Sam Bobroff wrote:
> Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
> determine if a PowerPC KVM guest should use HTM (Hardware Transactional
> Memory).
> 
> This will be used by QEMU to populate the pa-features bits in the
> guest's device tree.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> 
Make sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
