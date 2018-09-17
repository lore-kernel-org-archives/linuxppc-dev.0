Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D9J94HrYzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 12:37:13 +1000 (AEST)
Received: by mail-qk1-x744.google.com with SMTP id 130-v6so8265607qkd.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 19:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180905020951.10372-1-sjitindarsingh@gmail.com>
 <20180905020951.10372-2-sjitindarsingh@gmail.com>
In-Reply-To: <20180905020951.10372-2-sjitindarsingh@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Sep 2018 12:07:00 +0930
Message-ID: <CACPK8XeZS1b0iZwmL2BicLB3=hA1XNajo+vbva9hkr=FXHXhQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/prom: Remove VLA in
 prom_check_platform_support()
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
> In prom_check_platform_support() we retrieve and parse the
> "ibm,arch-vec-5-platform-support" property of the chosen node.
> Currently we use a variable length array however to avoid this use an
> array of constant length 8.
>
> This property is used to indicate the supported options of vector 5
> bytes 23-26 of the ibm,architecture.vec node. Each of these options
> is a pair of bytes, thus for 4 options we have a max length of 8 bytes.
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
