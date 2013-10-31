Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1CA32C039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 19:06:43 +1100 (EST)
Date: Thu, 31 Oct 2013 15:44:37 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Message-ID: <20131031074436.GG9605@MrMyself>
References: <cover.1383197521.git.b42378@freescale.com>
 <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
 <52720CA4.3090003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <52720CA4.3090003@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 galak@codeaurora.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Philippe

On Thu, Oct 31, 2013 at 08:54:12AM +0100, Philippe R=E9tornaz wrote:
> Hi
>=20
> >
> >+			/* When using dual fifo mode, we need to keep watermark
> >+			 * as even numbers due to dma script limitation.
> >+			 */
> >+			ssi_private->dma_params_tx.maxburst /=3D 2;
> >+			ssi_private->dma_params_tx.maxburst *=3D 2;
> >+			ssi_private->dma_params_rx.maxburst /=3D 2;
> >+			ssi_private->dma_params_rx.maxburst *=3D 2;
> >
>=20
> Why not using a mask here ?
> ssi_private->dma_params_tx.maxburst &=3D ~0x1;
> ssi_private->dma_params_rx.maxburst &=3D ~0x1;

I'll use this in v3. Thank you!

Nicolin Chen

>=20
> Regards,
>=20
> Philippe
>=20
>=20
