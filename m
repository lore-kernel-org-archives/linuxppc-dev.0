Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hFhg4C6WzF2SD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 11:17:55 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id y8-v6so284597ual.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 18:17:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510010424.16854-2-npiggin@gmail.com>
References: <20180510010424.16854-1-npiggin@gmail.com>
 <20180510010424.16854-2-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 10 May 2018 11:17:51 +1000
Message-ID: <CAKTCnznk6q1mVDUZsqt7Kuev=WG4XV-9+sZUihEjCgLrC7VD4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: change softe to irqmask in show_regs and
 xmon
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 10, 2018 at 11:04 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> When the soft enabled flag was changed to a soft disable mask, xmon
> and register dump code was not updated to reflect that, which is
> confusing ('SOFTE: 1' previously meant interrupts were soft enabled,
> currently it means the opposite, the general interrupt type has been
> disabled).
>
> Fix this by using the name irqmask, and printing it in hex.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>

Acked-by: Balbir Singh <bsingharora@gmail.com>
