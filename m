Return-Path: <danielwa@cisco.com>
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LjlB3LC8zF37d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 04:19:50 +1000 (AEST)
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Walker <dwalker@fifo99.com>, Andrii Bordunov <aborduno@cisco.com>,
 Ruslan Bilovol <rbilovol@cisco.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, linux-mips
 <linux-mips@linux-mips.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <3320a561-2287-63f7-2162-84a639a22a8a@cisco.com>
Date: Thu, 27 Sep 2018 11:08:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2018 10:05 AM, Ard Biesheuvel wrote:
> On 27 September 2018 at 18:55, Maksym Kokhan
> <maksym.kokhan@globallogic.com> wrote:
>> There were series of patches [1] for 4.3.0-rc3, that allowed
>> architectures to use a generic builtin command line. I have rebased
>> these patches on kernel 4.19.0-rc4.
>>
> 
> Could you please elaborate on the purpose of this series? Is it simply
> to align between architectures? Does it solve an actual problem?

1) It removed a lot of code duplication between architecture

2) At Cisco we have issues where our bootloaders having default boot 
arguments. Some platforms we can't update the boot loader and it's 
helpful to be able to have boot arguments which are prepended to the 
bootloader arguments , and some parameters which are appended. These 
changes allow that.

Daniel
