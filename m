Return-Path: <jwboyer@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8952DB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 00:54:29 +1100 (EST)
Received: by werg1 with SMTP id g1so2489288wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 05:54:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1324385014-30725-1-git-send-email-vhtnguyen@apm.com>
References: <1324385014-30725-1-git-send-email-vhtnguyen@apm.com>
Date: Wed, 29 Feb 2012 08:54:26 -0500
Message-ID: <CA+5PVA5SZmeEdBF0XvNmvCwroCKs1EwdWNbd_nwyEDCoZGHo2Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/44x: The bug fixed support for APM821xx SoC
 and Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2011 at 7:43 AM, Vinh Nguyen Huu Tuong
<vhtnguyen@apm.com> wrote:
> This patch consists of:
> - Fix the pvr mask for checking pvr in cputable.c
> - Fix the cpu name as consistent with cpu name is describled in dts file
>
> Signed-off-by: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
> ---

I was waiting to see if you would submit a new series with patch 3/3 fixed for
the comments I made.  Seems you haven't yet or I missed it entirely.  For now,
I'll take this patch as it's stand-alone.  The DTS and PCI driver patches will
need to be submitted together again.

josh
