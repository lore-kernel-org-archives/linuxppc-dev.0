Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1347465937-7056-1-git-send-email-cyril@ti.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
Date: Wed, 12 Sep 2012 18:16:09 +0200
Message-ID: <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Cyril Chemparathy <cyril@ti.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, x86@kernel.org, a-jacquiot@ti.com,
 mahesh@linux.vnet.ibm.com, linus.walleij@linaro.org,
 paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
 m.szyprowski@samsung.com, jonas@southpole.se, linux@arm.linux.org.uk,
 linux-c6x-dev@linux-c6x.org, nico@linaro.org, david.daney@cavium.com,
 mingo@redhat.com, suzuki@in.ibm.com, linux-arm-kernel@lists.infradead.org,
 linux@openrisc.net, arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
 devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
 rob.herring@calxeda.com, tglx@linutronix.de, bigeasy@linutronix.de,
 blogic@openwrt.org, dhowells@redhat.com, monstr@monstr.eu,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, tj@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2012 at 6:05 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> On some PAE architectures, the entire range of physical memory could reside
> outside the 32-bit limit.  These systems need the ability to specify the
> initrd location using 64-bit numbers.
>
> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> use 64-bit numbers instead of the current unsigned long.

> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)

Why not phys_addr_t?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
