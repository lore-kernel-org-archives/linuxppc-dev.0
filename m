Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 827EA1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 17:03:57 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id q63so26882771pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 22:03:57 -0800 (PST)
Subject: Re: [PATCH V4 05/18] powerpc/mm: Don't have conditional defines for
 real_pte_t
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE9946.1060707@gmail.com>
Date: Thu, 25 Feb 2016 17:03:50 +1100
MIME-Version: 1.0
In-Reply-To: <1456202900-5454-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23/02/16 15:48, Aneesh Kumar K.V wrote:
> We remove real_pte_t out of STRICT_MM_TYPESCHECK.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
The changelog does not explain why

Balbir
