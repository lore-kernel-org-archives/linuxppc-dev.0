Return-Path: <keescook@google.com>
Received: from mail-vc0-x235.google.com (mail-vc0-x235.google.com
 [IPv6:2607:f8b0:400c:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D6D71A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 09:22:03 +1100 (AEDT)
Received: by mail-vc0-f181.google.com with SMTP id le20so5282130vcb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2015 14:22:00 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150302132657.5507742399620e70dd0a3926@linux-foundation.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
 <20150302132657.5507742399620e70dd0a3926@linux-foundation.org>
Date: Mon, 2 Mar 2015 14:22:00 -0800
Message-ID: <CAGXu5j+qOntXiF_zzW-+fGWeU-tBxwSF2UVsLm5D6brNEf-XCw@mail.gmail.com>
Subject: Re: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Min-Hua Chen <orca.chen@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ismael Ripoll <iripoll@upv.es>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 2, 2015 at 1:26 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 26 Feb 2015 19:07:09 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> This separates ET_DYN ASLR from mmap ASLR, as already done on s390. The
>> various architectures that are already randomizing mmap (arm, arm64, mips,
>> powerpc, s390, and x86), have their various forms of arch_mmap_rnd()
>> made available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these
>> architectures, arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>
> "504 Gateway Time-out"
>
> Hector's original patch had very useful descriptions of the bug, why it
> occurred, how it was exploited it and how the patch fixes it.
>
> Your changelogs contain none of this and can be summarized as "randomly
> churn code around for no apparent reason".
>
> Wanna try again?  I guess the [0/5] and [4/5] changelogs are the ones
> to fix.

Ah, yes, absolutely. I will resend.

-Kees

-- 
Kees Cook
Chrome OS Security
