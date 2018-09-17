Return-Path: <joel.stan@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D9JT27KRzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 12:37:29 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id z8-v6so13994632qto.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 19:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180905020951.10372-1-sjitindarsingh@gmail.com>
 <20180905020951.10372-3-sjitindarsingh@gmail.com>
In-Reply-To: <20180905020951.10372-3-sjitindarsingh@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Sep 2018 12:07:16 +0930
Message-ID: <CACPK8XckWVGGWXeUU+SViJZwRwqMDK8j9MAPck5xYbL6PVTwZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/pseries: Remove VLA from lparcfg_write()
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2018 at 11:40, Suraj Jitindar Singh
<sjitindarsingh@gmail.com> wrote:
>
> In lparcfg_write we hard code kbuf_sz and then use this as the variable
> length of kbuf creating a variable length array. Since we're hard coding
> the length anyway just define the array using this as the length and
> remove the need for kbuf_sz, thus removing the variable length array.
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
