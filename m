Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1412659726-29957-36-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-36-git-send-email-linux@roeck-us.net>
Date: Tue, 7 Oct 2014 11:19:36 +0200
Message-ID: <CAMuHMdVZmsjK9FdK0T6mWwrnNc=Xc97B7ynm+QbWUMBCnvQB_g@mail.gmail.com>
Subject: Re: [PATCH 35/44] m68k: Register with kernel poweroff handler
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m32r-ja@ml.linux-m32r.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-efi@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 driverdevel <devel@driverdev.osuosl.org>,
 linux-s390 <linux-s390@vger.kernel.org>, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 xen-devel@lists.xenproject.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

As someone already mentioned, having #defines instead of hardcoded
numbers for the priorities would be nice.

Apart from that:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> +       register_poweroff_handler_simple(nf_poweroff, 128);

> +       register_poweroff_handler_simple(mac_poweroff, 128);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
