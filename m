Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-x22d.google.com (mail-we0-x22d.google.com
 [IPv6:2a00:1450:400c:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 070B21A006F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 17:20:00 +1100 (AEDT)
Received: by wesp10 with SMTP id p10so15350278wes.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 22:19:54 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 27 Feb 2015 07:19:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150227061949.GA25810@gmail.com>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 linux-fsdevel@vger.kernel.org, Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, Oleg Nesterov <oleg@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kees Cook <keescook@chromium.org> wrote:

> This separates ET_DYN ASLR from mmap ASLR, as already 
> done on s390. The various architectures that are already 
> randomizing mmap (arm, arm64, mips, powerpc, s390, and 
> x86), have their various forms of arch_mmap_rnd() made 
> available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For 
> these architectures, arch_randomize_brk() is collapsed as 
> well.
> 
> This is an alternative to the solutions in: 
> https://lkml.org/lkml/2015/2/23/442

Nice!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
