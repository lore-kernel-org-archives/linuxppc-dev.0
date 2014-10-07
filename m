Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAB2D1A0608
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 01:06:15 +1100 (EST)
Message-ID: <5433F197.8040801@nod.at>
Date: Tue, 07 Oct 2014 15:58:47 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Jonas Bonn <jonas@southpole.se>, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 Steven Miao <realmz6@gmail.com>, linux-xtensa@linux-xtensa.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, lguest@lists.ozlabs.org,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 Len Brown <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>,
 linux-hexagon@vger.kernel.org, Hirokazu Takata <takata@linux-m32r.org>,
 linux-sh@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Chen Liqin <liqin.linux@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 devicetree@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 adi-buildroot-devel@lists.sourceforge.net, Chris Metcalf <cmetcalf@tilera.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mikael Starvik <starvik@axis.com>, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 Vineet Gupta <vgupta@synopsys.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Richard Kuo <rkuo@codeaurora.org>,
 David Vrabel <david.vrabel@citrix.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 07.10.2014 07:28, schrieb Guenter Roeck:
>  arch/um/kernel/reboot.c            |  2 --

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
