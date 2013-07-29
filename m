Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 075EE2C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 08:09:39 +1000 (EST)
Date: Mon, 29 Jul 2013 17:09:32 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 1/3] DMA: Freescale: revise device tree binding document
To: <hongbo.zhang@freescale.com>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Mon Jul 29 05:49:02 2013)
Message-ID: <1375135772.30721.59@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@freescale.com>,
 djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 05:49:02 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> This patch updates the discription of each type of DMA controller and =20
> its
> channels, it is preparation for adding another new DMA controller =20
> binding, it
> also fixes some defects of indent for text alignment at the same time.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>

ACK, but next time please do the whitespace fixes as a separate patch =20
so that it's easier to see what's actually changing.

-Scott=
