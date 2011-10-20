Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AA584B70CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:13:27 +1100 (EST)
Received: by ggnk1 with SMTP id k1so2757330ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 02:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630133-14264-1-git-send-email-tmarri@apm.com>
References: <1318630133-14264-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 14:43:24 +0530
Message-ID: <CAHM4w1mFawyyTiG8vQQh804sdfFCH9KMrQA=10WouSx-oLz4SA@mail.gmail.com>
Subject: Re: [PATCH v15 04/10] USB/ppc4xx: Add Synopsys DWC OTG HCD function
From: Pratyush Anand <pratyush.anand@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 15, 2011 at 3:38 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>

[...]

Everything fine in this patch, except the defines of TX
regs(DWC_RX_FIFO_DEPTH_WR) has been
kept with RX.

Regards
Pratyush
