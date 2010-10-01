Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id A1ACFB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 21:28:32 +1000 (EST)
Received: by wwa36 with SMTP id 36so2766631wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 04:28:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F7E7DAE6-A132-458D-ABC3-4CC92A4C7263@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
	<F7E7DAE6-A132-458D-ABC3-4CC92A4C7263@kernel.crashing.org>
Date: Fri, 1 Oct 2010 07:28:30 -0400
Message-ID: <AANLkTimGtB_KoOgwk3Ujn2UcNzs9qHxzeZcb1ShLgcXh@mail.gmail.com>
Subject: Re: [PATCH 01/18] powerpc: Add ability to build little endian kernels
From: Josh Boyer <jwboyer@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 5:18 AM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:
>
> On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:
>
>>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platf=
orms/Kconfig.cputype
>> index d361f81..074ff12 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -329,3 +329,19 @@ config CHECK_CACHE_COHERENCY
>> =A0 =A0 =A0 bool
>>
>> endmenu
>> +
>> +config ARCH_SUPPORTS_LITTLE_ENDIAN
>> + =A0 =A0 bool
>> +
>> +config CPU_LITTLE_ENDIAN
>> + =A0 =A0 bool "Build little endian kernel"
>> + =A0 =A0 depends on ARCH_SUPPORTS_LITTLE_ENDIAN && EXPERIMENTAL
>> + =A0 =A0 default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This option selects whether a big endian or little endian =
kernel will
>> + =A0 =A0 =A0 be built.
>> +
>> + =A0 =A0 =A0 Note that if building a little endian kernel, CROSS_COMPIL=
E must
>> + =A0 =A0 =A0 point to a toolchain capable of targetting little endian p=
owerpc,
>> + =A0 =A0 =A0 while the toolchain specified by CROSS32_COMPILE must be c=
apable of
>> + =A0 =A0 =A0 targetting *BIG* endian PowerPC.
>> --
>> 1.7.1
>
> Shouldn't we have something that limits to the sub-arch'es that actually =
support it? =A0I doubt I'm ever going to make FSL-Book-e support LE.

Yes, it should.

josh
