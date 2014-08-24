Return-Path: <gang.chen.5i5j@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A04831A0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Aug 2014 18:34:23 +1000 (EST)
Received: by mail-pa0-f46.google.com with SMTP id lj1so18954062pab.19
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Aug 2014 01:34:21 -0700 (PDT)
Message-ID: <53F9A48F.3020803@gmail.com>
Date: Sun, 24 Aug 2014 16:38:39 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org>
 <53ED34CE.3040001@gmail.com> <53EDCC60.5040608@gmail.com>
In-Reply-To: <53EDCC60.5040608@gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, a-jacquiot@ti.com, catalin.marinas@arm.com,
 linux@openrisc.net, will.deacon@arm.com, dhowells@redhat.com,
 jcmvbkbc@gmail.com, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-s390@vger.kernel.org, gxt@mprc.pku.edu.cn,
 Jean Delvare <jdelvare@suse.de>, egtvedt@samfundet.no, jonas@southpole.se,
 Liqin Chen <liqin.linux@gmail.com>, jesper.nilsson@axis.com,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-c6x-dev@linux-c6x.org, "David S. Miller" <davem@davemloft.net>,
 linux-xtensa@linux-xtensa.org, takata@linux-m32r.org, x86@kernel.org,
 jejb@parisc-linux.org, torvalds@linux-foundation.org, linux-sh@vger.kernel.org,
 mingo@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 Lennox Wu <lennox.wu@gmail.com>, msalter@redhat.com, mattst88@gmail.com,
 hskinnemoen@gmail.com, fenghua.yu@intel.com, james.hogan@imgtec.com,
 Arnd Bergmann <arnd@arndb.de>, realmz6@gmail.com, heiko.carstens@de.ibm.com,
 jdike@addtoit.com, linux-alpha@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, cmetcalf@tilera.com,
 starvik@axis.com, linux-m32r@ml.linux-m32r.org, ink@jurassic.park.msu.ru,
 user-mode-linux-user@lists.sourceforge.net, tglx@linutronix.de,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rth@twiddle.net, chris@zankel.net, Michal Simek <monstr@monstr.eu>,
 tony.luck@intel.com, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, vgupta@synopsys.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rkuo@codeaurora.org, user-mode-linux-devel@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, yasutake.koichi@jp.panasonic.com,
 linuxppc-dev@lists.ozlabs.org, deller@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Maintainers:

Is this patch OK? If it pass basic checking, please let me know, and I
shall try to make another related patch for KBuild (I can do nothing
related with Kbuild, before get confirmation for this patch).

Thanks.

On 8/15/14 17:01, Chen Gang wrote:
> 
> 
> On 8/15/14 6:14, Chen Gang wrote:
>> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>>
>>
>> OK, thanks, I assumes when support both endian, the default choice is
>> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
>> worry about it).
>>
>>> So I think you can just drop the MIPS segment from your patch.
>>>
>>
>> If what I assumes is correct, what you said sounds reasonable to me.
>>
>>
> 
> So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
> other members don't need think of.
> 
> By the way, for sh, it is almost the same case, except it contents the
> default value, for me, it is clear enough, so I skip sh architecture in
> this patch.
> 
> 
> Thanks
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
