Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjk9P2C6TzDqMp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 08:43:21 +1000 (AEST)
Received: by mail-ot0-f193.google.com with SMTP id i31so2206178ota.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 15:43:21 -0700 (PDT)
Date: Wed, 7 Jun 2017 17:43:18 -0500
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
Subject: Re: [PATCH v3 6/6] dt-bindings: net: btusb: DT fix
 s/interrupt-name/interrupt-names/
Message-ID: <20170607224318.wswmmhdwmqtvvqob@rob-hp-laptop>
References: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
 <1496407129-13527-7-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496407129-13527-7-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 02, 2017 at 02:38:49PM +0200, Geert Uytterhoeven wrote:
> Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
