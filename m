Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlrs34TlLzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 16:50:15 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id c20so43169231pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 23:50:15 -0700 (PDT)
Subject: Re: [PATCH V2 25/68] powerpc/mm: Move pte related function together
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-26-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570F3D9A.6050301@gmail.com>
Date: Thu, 14 Apr 2016 16:50:02 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-26-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Only code movement. No functionality change.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 142 +++++++++++++--------------
>  1 file changed, 71 insertions(+), 71 deletions(-)

Acked-by: balbir Singh <bsingharora@gmail.com>
