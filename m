Return-Path: <ego.lkml@gmail.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXj8k4ymfzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 02:26:14 +1100 (AEDT)
Received: by mail-ua0-x22d.google.com with SMTP id 72so16930800uaf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 07:26:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: ego@linux.vnet.ibm.com
In-Reply-To: <20170216183901.28611-5-npiggin@gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
 <20170216183901.28611-5-npiggin@gmail.com>
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Tue, 28 Feb 2017 20:56:11 +0530
Message-ID: <CAHZ_5WyGWuTPSHAsQJjvGxqMeEjFEa+m47py6OmBe4L2yDSRGw@mail.gmail.com>
Subject: Re: [PATCH 4/5] powerpc/64s: consolidate pnv_restore_hyp_resource
 into pnv_powersave_wakeup
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Fri, Feb 17, 2017 at 12:09 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> There is only one caller, so this reduces spaghetti of subsequent
> callees returning into the caller.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This patch is good!

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.
