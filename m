Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 591572C0356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 00:03:38 +1100 (EST)
From: Chen Guangyu-B42378 <B42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
Date: Tue, 29 Oct 2013 13:03:26 +0000
Message-ID: <uq0wlfsid450p3ufwptuuscw.1383051812670@email.android.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,
 <526FAD41.2000805@tabi.org>
 <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>,
 <526FB17C.3090009@tabi.org>
In-Reply-To: <526FB17C.3090009@tabi.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Huang Shijie-B32955 <B32955@freescale.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you, sir. And sorry for taking your time.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Chen Guangyu-B42378 wrote:
> Without dual fifo support,  handware underrun would occasionally
> occur and then two audio channels would physically swap. This could
> be easily reproduced in low bus frequency situation, while it would
> be better if we enable dual fifo.

Ok.

ACK.
