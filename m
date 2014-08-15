Return-Path: <gang.chen.5i5j@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 140801A05EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 11:25:35 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id g10so2518082pdj.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 18:25:33 -0700 (PDT)
Message-ID: <53ED628D.8010807@gmail.com>
Date: Fri, 15 Aug 2014 09:29:49 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
 <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
 <53ED36AB.8020703@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=windows-1252
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
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "David S. Miller" <davem@davemloft.net>,
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
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
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



On 8/15/14 7:12, Vineet Gupta wrote:
> On Thursday 14 August 2014 03:22 PM, Chen Gang wrote:
>> For many individual modules may need check CPU_LITTLE_ENDIAN or
>> CPU_BIG_ENDIAN, which is an architecture's attribute.
>>
>> Or they have to list many architectures which they support, which they
>> don't support. And still, it is not precise.
>>
>> For architecture API, endian is a main architecture's attribute which
>> may be used by outside, so every architecture need let outside know
>> about it, explicitly.
> 
> I don't think that is correct. The modules need to use standard API e.g. swab
> which will take care of proper endian handling anyways. Why would a module do
> anything endian specific outside of those APIs.
> 

For building time, modules can check endians with various API. But for
config time, at present, we have no related standard API for it.

> And again is this churn just theoretical or do you really have a issue at hand ! I
> would not accept a change for ARC unless you prove that something is broken (or
> atleast potentially broken) !
> 

An issue for allmodconfig under microblaze, the original patch is below
(I guess, not only one module may match this case):


-------- Forwarded Message --------
Subject: [PATCH] drivers/isdn/hisax/Kconfig: Let HISAX_NETJET skip microblaze architecture
Date: Tue, 05 Aug 2014 02:24:09 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
To: isdn@linux-pingi.de
CC: davem@davemloft.net, Jean Delvare <jdelvare@suse.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, monstr@monstr.eu

For HISAX_NETJET, HISAX_NETJET_U or related config needs !__BIG_ENDIAN,
so skip microblaze, just like skip all other architectures which have
no CONFIG_*_ENDIAN.

The related error (with allmodconfig under microblaze):

    CC [M]  drivers/isdn/hisax/nj_s.o
  drivers/isdn/hisax/nj_s.c: In function 'setup_netjet_s':
  drivers/isdn/hisax/nj_s.c:265:2: error: #error "not running on big endian machines now"
   #error "not running on big endian machines now"
    ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/isdn/hisax/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index 97465ac..eb83d94 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -237,7 +237,7 @@ config HISAX_MIC
 
 config HISAX_NETJET
 	bool "NETjet card"
-	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN)))
+	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN) || MICROBLAZE))
 	depends on VIRT_TO_BUS
 	help
 	  This enables HiSax support for the NetJet from Traverse
@@ -249,7 +249,7 @@ config HISAX_NETJET
 
 config HISAX_NETJET_U
 	bool "NETspider U card"
-	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN)))
+	depends on PCI && (BROKEN || !(PPC || PARISC || M68K || (MIPS && !CPU_LITTLE_ENDIAN) || FRV || (XTENSA && !CPU_LITTLE_ENDIAN) || MICROBLAZE))
 	depends on VIRT_TO_BUS
 	help
 	  This enables HiSax support for the Netspider U interface ISDN card





Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
