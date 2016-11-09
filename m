Return-Path: <robherring2@gmail.com>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDZMh0XBKzDvd4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 05:24:32 +1100 (AEDT)
Received: by mail-it0-f67.google.com with SMTP id n68so16142759itn.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 10:24:31 -0800 (PST)
Date: Wed, 9 Nov 2016 12:24:28 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] ARM: shmobile: Document DT bindings for CCCR and
 PRR
Message-ID: <20161109182428.lgwo4rqfxelibl3h@rob-hp-laptop>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1477913455-5314-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477913455-5314-6-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2016 at 12:30:53PM +0100, Geert Uytterhoeven wrote:
> Add device tree binding documentation for the Common Chip Code Register
> and Product Register, which provide SoC product and revision
> information.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
