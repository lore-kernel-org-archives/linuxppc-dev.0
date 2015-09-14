Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <f9c28dfbef66b7f23f1e542397bd6a77d1258ddd.1442259101.git.geoff@infradead.org>
References: <cover.1442259101.git.geoff@infradead.org>
 <f9c28dfbef66b7f23f1e542397bd6a77d1258ddd.1442259101.git.geoff@infradead.org>
Date: Mon, 14 Sep 2015 22:13:16 +0200
Message-ID: <CAMuHMdWSqW=toM2hPiXV5UGjcbSZ91YN_26w-JFnTQN80Ok9jQ@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] powerpc/ps3: Refresh ps3_defconfig
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geoff,

On Mon, Sep 14, 2015 at 9:35 PM, Geoff Levand <geoff@infradead.org> wrote:
> diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
> index adc14e8..09f117e 100644
> --- a/arch/powerpc/configs/ps3_defconfig
> +++ b/arch/powerpc/configs/ps3_defconfig

> @@ -142,7 +141,6 @@ CONFIG_RTC_DRV_PS3=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT2_FS=m
>  CONFIG_EXT3_FS=m
> -# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set

Given Ext3 support was removed, and although the Kconfig symbol was kept for
(temporary?) backwards compatibility, I think these should be updated.

>  CONFIG_EXT4_FS=y
>  CONFIG_QUOTA=y
>  CONFIG_QFMT_V2=y

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
