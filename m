Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnrS821nJzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 22:39:04 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id 184so71894817pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 05:39:04 -0700 (PDT)
Date: Sun, 17 Apr 2016 05:38:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: zengzhaoxiu@163.com
Cc: linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
 adi-buildroot-devel@lists.sourceforge.net,
 Andrew Morton <akpm@linux-foundation.org>,
 Anton Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Borislav Petkov <bp@suse.de>, Bruce Allan <bruce.w.allan@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 David Herrmann <dh.herrmann@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Duson Lin <dusonlin@emc.com.tw>, Guenter Roeck <linux@roeck-us.net>,
 Hans de Goede <hdegoede@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ingo Molnar <mingo@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 linux-crypto@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux@lists.openrisc.net,
 linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Martin Kepplinger <martink@posteo.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Michal Nazarewicz <mina86@mina86.com>, netdev@vger.kernel.org,
 Peter Hutterer <peter.hutterer@who-t.net>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pingchao Yang <pingchao.yang@intel.com>, qat-linux@intel.com,
 Ralf Baechle <ralf@linux-mips.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Sasha Levin <sasha.levin@oracle.com>, Scott Wood <oss@buserror.net>,
 sparclinux@vger.kernel.org, Tadeusz Struk <tadeusz.struk@intel.com>,
 Takashi Iwai <tiwai@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Torsten Duwe <duwe@lst.de>, uclinux-h8-devel@lists.sourceforge.jp,
 Ulrik De Bie <ulrik.debie-os@e2big.org>,
 Vineet Gupta <vgupta@synopsys.com>, Vlastimil Babka <vbabka@suse.cz>,
 "wim.coekaerts@oracle.com" <wim.coekaerts@oracle.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yury Norov <yury.norov@gmail.com>,
 =?utf-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Subject: Re: [PATCH V3 00/29] bitops: add parity functions
Message-ID: <20160417123857.GD33215@dtor-ws>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2016 at 10:36:41AM +0800, zengzhaoxiu@163.com wrote:
>  drivers/input/joystick/grip_mp.c             |  16 +--
>  drivers/input/joystick/sidewinder.c          |  24 +----
>  drivers/input/mouse/elantech.c               |  10 +-
>  drivers/input/mouse/elantech.h               |   1 -
>  drivers/input/serio/ams_delta_serio.c        |   8 +-
>  drivers/input/serio/pcips2.c                 |   2 +-
>  drivers/input/serio/sa1111ps2.c              |   2 +-

For input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
