Return-Path: <gang.chen.5i5j@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 571741A0215
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 08:22:55 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id g10so2281421pdj.26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 15:22:53 -0700 (PDT)
Message-ID: <53ED36AB.8020703@gmail.com>
Date: Fri, 15 Aug 2014 06:22:35 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
 <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
In-Reply-To: <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
 "jdike@addtoit.com" <jdike@addtoit.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
 Arnd Bergmann <arnd@arndb.de>, "realmz6@gmail.com" <realmz6@gmail.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 Vineet Gupta <Vineet.Gupta1@synopsys.com>,
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

On 08/15/2014 02:27 AM, Lennox Wu wrote:
> I don't think it's necessary, what's the benfit?
> 
> 2014-08-15 2:21 GMT+08:00 Vineet Gupta <Vineet.Gupta1@synopsys.com>:
> 
>> On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
[...]
>>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>>> index 9596b0a..e939abd 100644
>>> --- a/arch/arc/Kconfig
>>> +++ b/arch/arc/Kconfig
>>> @@ -35,6 +35,7 @@ config ARC
>>>       select OF_EARLY_FLATTREE
>>>       select PERF_USE_VMALLOC
>>>       select HAVE_DEBUG_STACKOVERFLOW
>>> +     select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>
>> It is not clear what exactly are you trying to fix. What doesn't work w/o
>> this
>> patch !
>>

For many individual modules may need check CPU_LITTLE_ENDIAN or
CPU_BIG_ENDIAN, which is an architecture's attribute.

Or they have to list many architectures which they support, which they
don't support. And still, it is not precise.

For architecture API, endian is a main architecture's attribute which
may be used by outside, so every architecture need let outside know
about it, explicitly.


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
