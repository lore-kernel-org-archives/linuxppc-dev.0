Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 2BB372C033B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:59:48 +1100 (EST)
Message-ID: <526FA330.3080209@tabi.org>
Date: Tue, 29 Oct 2013 06:59:44 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>, broonie@kernel.org
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE
 in trigger()
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
In-Reply-To: <1383044688-28596-1-git-send-email-b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
> This patch enables Tx-related SIER_FLAGS only when direction is PLAYBACK
> and does same thing for CAPTURE. Also, after TRIGGER_STOP/PAUSE, it will
> disable SIER_xFLAGS for symmetric.

I'm okay with this patch in principle, but why bother?  The sysfs entry 
is going to display all interrupts anyway, and so the result will be the 
same.
