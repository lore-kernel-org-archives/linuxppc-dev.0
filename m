Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com
 [198.182.44.111])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54B531A067B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 09:14:04 +1000 (EST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Chen Gang <gang.chen.5i5j@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Date: Thu, 14 Aug 2014 23:12:53 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
 <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
 <53ED36AB.8020703@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>, Jean Delvare <jdelvare@suse.de>,
 "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
 "jonas@southpole.se" <jonas@southpole.se>, Liqin Chen <liqin.linux@gmail.com>,
 "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "David S.
 Miller" <davem@davemloft.net>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "takata@linux-m32r.org" <takata@linux-m32r.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
 Arnd Bergmann <arnd@arndb.de>, "realmz6@gmail.com" <realmz6@gmail.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "jdike@addtoit.com" <jdike@addtoit.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "cmetcalf@tilera.com" <cmetcalf@tilera.com>,
 "starvik@axis.com" <starvik@axis.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "rth@twiddle.net" <rth@twiddle.net>, "chris@zankel.net" <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 Richard Weinberger <richard@nod.at>, Martin
 Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "deller@gmx.de" <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 14 August 2014 03:22 PM, Chen Gang wrote:=0A=
> For many individual modules may need check CPU_LITTLE_ENDIAN or=0A=
> CPU_BIG_ENDIAN, which is an architecture's attribute.=0A=
>=0A=
> Or they have to list many architectures which they support, which they=0A=
> don't support. And still, it is not precise.=0A=
>=0A=
> For architecture API, endian is a main architecture's attribute which=0A=
> may be used by outside, so every architecture need let outside know=0A=
> about it, explicitly.=0A=
=0A=
I don't think that is correct. The modules need to use standard API e.g. sw=
ab=0A=
which will take care of proper endian handling anyways. Why would a module =
do=0A=
anything endian specific outside of those APIs.=0A=
=0A=
And again is this churn just theoretical or do you really have a issue at h=
and ! I=0A=
would not accept a change for ARC unless you prove that something is broken=
 (or=0A=
atleast potentially broken) !=0A=
=0A=
-Vineet=0A=
