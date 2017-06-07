Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjk906yXmzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 08:43:00 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id d99so1738282oic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 15:43:00 -0700 (PDT)
Date: Wed, 7 Jun 2017 17:42:57 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Chanho Min <chanho.min@lge.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/6] dt-bindings: display: amlogic: DT fix
 s/resets-names/reset-names/
Message-ID: <20170607224257.aqwrv7ryxrtr7yva@rob-hp-laptop>
References: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
 <1496407129-13527-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496407129-13527-6-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 02, 2017 at 02:38:48PM +0200, Geert Uytterhoeven wrote:
> Fixes: 8cceda5349377e30 ("dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
