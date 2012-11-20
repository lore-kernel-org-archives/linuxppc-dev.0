Return-Path: <viresh.linux@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FB592C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 14:07:57 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fq11so1996519vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 19:07:55 -0800 (PST)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1353349642-3677-226-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-226-git-send-email-wfp5p@virginia.edu>
Date: Tue, 20 Nov 2012 08:37:54 +0530
Message-ID: <CAOh2x=mM5E4+cmgaO4PZjyCp3EDixev5A+rNGw0WJ2G5WRVJ4w@mail.gmail.com>
Subject: Re: [PATCH 226/493] dma: remove use of __devinit
From: viresh kumar <viresh.kumar@linaro.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gregkh@linuxfoundation.org, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua.song@csr.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 11:52 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Zhang Wei <zw@zh-kernel.org>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/dma/dw_dmac.c         | 4 ++--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
