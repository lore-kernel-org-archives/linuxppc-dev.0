Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 685DF1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 09:27:07 +1100 (AEDT)
Received: by mail-wm0-x22a.google.com with SMTP id p63so2949734wmp.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 14:27:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1452251929-18368-1-git-send-email-raghav@freescale.com>
References: <1452251929-18368-1-git-send-email-raghav@freescale.com>
Date: Thu, 4 Feb 2016 16:27:03 -0600
Message-ID: <CADRPPNR9JJhGhoX6vCnnCTwCKS4a6dA1TPY=maL14=BCygCACg@mail.gmail.com>
Subject: Re: [PATCH][v2] drivers/memory: Add deep sleep support for IFC
From: Leo Li <pku.leo@gmail.com>
To: Raghav Dogra <raghav@freescale.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, oss@buserror.net,
 prabhakar.kushwaha@nxp.com, Prabhakar Kushwaha <prabhakar@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 8, 2016 at 5:18 AM, Raghav Dogra <raghav@freescale.com> wrote:
> Add support of suspend, resume function to support deep sleep.
> Also make sure of SRAM initialization  during resume.
>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
> Changes for v2: Copying only the correct registers while resume.
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> branch "next"

The patch can not apply cleanly on 4.5-rc.  You probably need to re-spin it.

Regards,
Leo
