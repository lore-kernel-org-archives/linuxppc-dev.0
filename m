Return-Path: <gxt@pku.edu.cn>
Date: Wed, 8 Oct 2014 19:06:32 +0800 (CST)
From: =?gbk?B?WHVldGFvIEd1YW4g?=<gxt@pku.edu.cn>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <218135571.28324.1412766392198.JavaMail.root@bj-mail03.pku.edu.cn>
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_[PATCH_08/44]_kernel:_Mov?=
 =?utf-8?Q?e_pm=5Fpower=5Foff_to_common_code?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, Steven Miao <realmz6@gmail.com>,
 linux-xtensa@linux-xtensa.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
 Chen Liqin <liqin.linux@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, devicetree@vger.kernel.org,
 James Hogan <james.hogan@imgtec.com>,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 adi-buildroot-devel@lists.sourceforge.net, Chris Metcalf <cmetcalf@tilera.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mikael Starvik <starvik@axis.com>, Richard Weinberger <richard@nod.at>,
 linux-am33-list@redhat.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 Vineet Gupta <vgupta@synopsys.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>, David Vrabel <david.vrabel@citrix.com>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
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


----- Guenter Roeck <linux@roeck-us.net> =E5=86=99=E9=81=93=EF=BC=9A
> pm_power_off is defined for all architectures. Move it to common code.
>=20
> Have all architectures call do_kernel_poweroff instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_poweroff from machine_power_off instead.
>=20

For UniCore32 part,

Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>

Thanks
Xuetao
