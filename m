Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0mBH3rWMzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:04:55 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id v81so10966238ywa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 00:04:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1462429482-1801-1-git-send-email-oohall@gmail.com>
References: <1462429482-1801-1-git-send-email-oohall@gmail.com>
Date: Thu, 5 May 2016 17:04:52 +1000
Message-ID: <CAKTCnzmd8ETbwRypEpinPbA1UGan9LONeaOvSJiiOfTjjAv4Vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/mm: define TOP_ZONE as a constant
From: Balbir Singh <bsingharora@gmail.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 5, 2016 at 4:24 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> The zone that contains the top of memory will be either ZONE_NORMAL
> or ZONE_HIGHMEM depending on the kernel config. There are two functions
> in that require this information and both of them use an #ifdef to set
> a local variable (top_zone). This is a little silly so lets just make it
> a constant.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---

I reviewed the previous version and there are no changes hence

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
