Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfLWZ5DRZzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 17:46:02 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id 184so5707584pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 00:46:02 -0700 (PDT)
Subject: Re: [PATCH 08/65] powerpc/mm: Update _PAGE_KERNEL_RO
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57036D32.2090004@gmail.com>
Date: Tue, 5 Apr 2016 17:45:54 +1000
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> PS3 had used PPP bit hack to implement a read only mapping in the
> kernel area. Since we are bolt mapping the ioremap area, it used
> the pte flags _PAGE_PRESENT | _PAGE_USER to get a PPP value of 0x3
> there by resulting in a read only mapping. This means the area
> can be accessed by user space, but kernel will never return such an
> address to user space.
>
> But we can do better by implementing a read only kernel mapping using
> PPP bits 0b110
Looks good!

Acked-by: Balbir Singh <bsingharora@gmail.com>
