Return-Path: <jwboyer@gmail.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com
 [IPv6:2607:f8b0:4003:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 409062C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 00:35:10 +1100 (EST)
Received: by mail-ob0-f176.google.com with SMTP id wo20so1206185obc.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 05:35:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393225256-21122-1-git-send-email-alistair@popple.id.au>
References: <1393225256-21122-1-git-send-email-alistair@popple.id.au>
Date: Mon, 24 Feb 2014 08:35:06 -0500
Message-ID: <CA+5PVA4Hx4iKkL+vLJjOTwMaKOL-dJPJpSHLjR+nU6MTTGvFcA@mail.gmail.com>
Subject: Re: [PATCH] ppc476: Enable a linker work around for IBM errata #46
From: Josh Boyer <jwboyer@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 24, 2014 at 2:00 AM, Alistair Popple <alistair@popple.id.au> wrote:
> This patch adds an option to enable a work around for an icache bug on
> 476 that can cause execution of stale instructions when falling
> through pages (IBM errata #46). It requires a recent version of
> binutils which supports the --ppc476-workaround option.
>
> The work around enables the appropriate linker options and ensures
> that all module output sections are aligned to 4K page boundaries. The
> work around is only required when building modules.

What happens if you're using 64K pages?  Is the alignment 4K always,
or does it need to be aligned to PAGE_SIZE?

josh
