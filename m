Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2A2E2C033F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:10:56 +1100 (EST)
Date: Tue, 29 Oct 2013 19:57:11 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE in
 trigger()
Message-ID: <20131029115711.GA9605@MrMyself>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <526FA330.3080209@tabi.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 29, 2013 at 06:59:44AM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >This patch enables Tx-related SIER_FLAGS only when direction is PLAYBACK
> >and does same thing for CAPTURE. Also, after TRIGGER_STOP/PAUSE, it will
> >disable SIER_xFLAGS for symmetric.
> 
> I'm okay with this patch in principle, but why bother?  The sysfs
> entry is going to display all interrupts anyway, and so the result
> will be the same.
>

Well, actually I just wanted to clear T/RDMAE to disable DMA request,
but it seems to be much easier to do it like this based on current
code and disabling unused interrupts should be better right? :)

Thank you,
Nicolin Chen
