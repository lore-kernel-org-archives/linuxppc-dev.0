Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4BB41A0214
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 11:35:17 +1000 (AEST)
References: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
 <59abec18b5cf1d8e05ba3ae4aad89719bbeca052.1436172253.git.zidan.wang@freescale.com>
In-Reply-To: <59abec18b5cf1d8e05ba3ae4aad89719bbeca052.1436172253.git.zidan.wang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Message-Id: <0CBF1167-B9A2-47DB-9E57-F3D55AEDD8A5@tabi.org>
Cc: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel][PATCH 2/2] ASoC: fsl_ssi: sound is wrong after
 suspend/resume
Date: Mon, 6 Jul 2015 21:35:12 -0400
To: Zidan Wang <zidan.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jul 6, 2015, at 4:49 AM, Zidan Wang wrote:

> The register SFCSR is volatile, but some bits in it need to be
> recovered after suspend/resume.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Shouldn't this be part of patch #1?
