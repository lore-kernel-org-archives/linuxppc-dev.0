Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D9C16qnqzF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 12:32:45 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id 130-v6so8262365qkd.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 19:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180914050854.6214-1-npiggin@gmail.com>
 <20180914050854.6214-3-npiggin@gmail.com>
In-Reply-To: <20180914050854.6214-3-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Sep 2018 12:02:32 +0930
Message-ID: <CACPK8XekkXwRqDd9z3VFQZVbmiDVV-W2nXqfy8u5DZPsZ+5fnA@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: consolidate -mno-sched-epilog into FTRACE
 flags
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2018 at 14:39, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
