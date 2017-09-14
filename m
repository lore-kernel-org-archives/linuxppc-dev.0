Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt5Pl1KvZzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 14:38:19 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e69so996410pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 21:38:18 -0700 (PDT)
Date: Thu, 14 Sep 2017 14:38:07 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
Message-ID: <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:44:50 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> powerpc needs an additional vma bit to support 32 keys.
> Till the additional vma bit lands in include/linux/mm.h
> we have to define  it  in powerpc specific header file.
> This is  needed to get pkeys working on power.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

"This" being an arch specific hack for the additional bit?

Balbir
