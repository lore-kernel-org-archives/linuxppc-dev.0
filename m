Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwTb374bDzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 17:53:03 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id n1so34166148pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:53:03 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Add out of bounds check to
 crash_shutdown_unregister()
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
References: <1461824265-30592-1-git-send-email-sjitindarsingh@gmail.com>
 <5721B3D1.2060007@gmail.com> <20160428171839.24d75017@dyn253.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5721C158.9090303@gmail.com>
Date: Thu, 28 Apr 2016 17:52:56 +1000
MIME-Version: 1.0
In-Reply-To: <20160428171839.24d75017@dyn253.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Thanks for taking a look Balbir, the size of crash_shutdown_handles is
> actually CRASH_HANDLER_MAX+1.
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>
