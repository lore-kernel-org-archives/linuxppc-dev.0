Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfP9C117gzDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:46:39 +1000 (AEST)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3wfP0Z2S42zMxD8t
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 14:39:10 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>, Chanho Min <chanho.min@lge.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/6] DT: Fix spelling of standard properties
Date: Fri,  2 Jun 2017 14:38:43 +0200
Message-Id: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

        Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and examples.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v3:
  - Drop patches that have been applied already,
  - Add Acked-by,
  - Add new patches 5 and 6.

Changes compared to v2:
  - Drop patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Split off "[PATCH v2 4/6] ASoC: davinci-mcbsp: DT fix
    s/interrupts-names/interrupt-names/" from the unrelated "[PATCH 06/14]
    dmaengine: bcm2835: DT spelling s/interrupts-names/interrupt-names/",
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Please apply where appropriate.

Thanks!

P.S. I used the following to detect misspellings:

    words="(address|clock|cooling|dma|gpio|index|interrupt|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"

    git grep -Ew "${words}s-names"
    git grep -E "[^-]\<${words}-name\>[^-]"
    git grep -Ew "#${words}s-cells"             # false positive phys-cells
    git grep -E "#${words}-cell\>[^-]"

    git grep -w adress-cells
    git grep -Ew "interrupts-(map|parent)"

Geert Uytterhoeven (6):
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  dt: booting-without-of: DT fix s/#interrupt-cell/#interrupt-cells/
  powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/
  dt-bindings: display: amlogic: DT fix s/resets-names/reset-names/
  dt-bindings: net: btusb: DT fix s/interrupt-name/interrupt-names/

 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 2 +-
 Documentation/devicetree/bindings/net/btusb.txt                     | 2 +-
 Documentation/devicetree/booting-without-of.txt                     | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                                  | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                                  | 2 +-
 arch/powerpc/boot/dts/acadia.dts                                    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
