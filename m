Return-Path: <dan.j.williams@intel.com>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9F051A006B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 03:32:16 +1100 (AEDT)
Received: by mail-yk0-x22d.google.com with SMTP id v14so54305019ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 08:32:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 08:32:11 -0800
Message-ID: <CAPcyv4gHuC1KWAy4zjZKSrrYq_JgnFgE75rCYkRqRSpFQb576Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
From: Dan Williams <dan.j.williams@intel.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 21, 2016 at 8:15 AM, Vasant Hegde
<hegdevasant@linux.vnet.ibm.com> wrote:
> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
> rtas_rmo_buf from user space is failing. Hence we are not able to make
> RTAS syscall.
>
> This patch calls page_is_rtas_user_buf before calling iomem_is_exclusive
> in  devmem_is_allowed(). This will allow user space to map rtas_rmo_buf
> and we are able to make RTAS syscall.
>
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> CC: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
