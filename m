Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tShHn6bzbzDvrV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 22:33:09 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id y68so8215665pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 03:33:09 -0800 (PST)
Subject: Re: [PATCH v7 1/7] powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-2-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <e80383c1-9c69-b818-5ca4-9e6a2b0435a2@gmail.com>
Date: Tue, 29 Nov 2016 22:33:01 +1100
MIME-Version: 1.0
In-Reply-To: <20161128061704.4914-2-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/11/16 17:16, Aneesh Kumar K.V wrote:
> We will start moving some book3s specific hugetlb functions there.

You mean for both radix and hash right?

Balbir
