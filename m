Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHSvk5567zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 10:29:54 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id y7so5527045pgb.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:29:54 -0700 (PDT)
Date: Thu, 19 Oct 2017 10:29:44 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 21/25] powerpc: introduce get_pte_pkey() helper
Message-ID: <20171019102944.40c9c232@MiWiFi-R3-srv>
In-Reply-To: <1504910713-7094-30-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-30-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:45:09 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> get_pte_pkey() helper returns the pkey associated with
> a address corresponding to a given mm_struct.
>

This is really get_mm_addr_key() -- no?

Balbir Singh.
