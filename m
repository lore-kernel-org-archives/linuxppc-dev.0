Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id A3E4D2C0342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:18:23 +1100 (EST)
Message-ID: <526FA78D.2090601@tabi.org>
Date: Tue, 29 Oct 2013 07:18:21 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE
 in trigger()
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
In-Reply-To: <20131029115711.GA9605@MrMyself>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Nicolin Chen wrote:
> Well, actually I just wanted to clear T/RDMAE to disable DMA request,
> but it seems to be much easier to do it like this based on current
> code and disabling unused interrupts should be better right?:)

It's not better if it complicates the code and has no real impact.  The 
code has been running fine for years the way it is.  Unless you can show 
me that it actually makes a difference, I will have to NACK this patch.
