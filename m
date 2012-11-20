Return-Path: <omaplinuxkernel@gmail.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B73A12C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 17:59:31 +1100 (EST)
Received: by mail-ie0-f179.google.com with SMTP id c10so7525220ieb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 22:59:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Date: Tue, 20 Nov 2012 12:29:29 +0530
Message-ID: <CAM=Q2ct2tzxV70CZ1ua8B-jSPFugDYTQJ3T6z7StKT1m3F-VsA@mail.gmail.com>
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Wolfram Sang <w.sang@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org,
 "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-i2c@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>,
 Jean Delvare <khali@linux-fr.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 11:50 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
 Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
