Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 878BD1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 01:47:12 +1100 (AEDT)
Date: Tue, 17 Mar 2015 14:47:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 03/10] arm64: standardize mmap_rnd() usage
Message-ID: <20150317144702.GN8399@arm.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425503454-7531-4-git-send-email-keescook@chromium.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Min-Hua Chen <orca.chen@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arun Chandran <achandran@mvista.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 04, 2015 at 09:10:47PM +0000, Kees Cook wrote:
> In preparation for splitting out ET_DYN ASLR, this refactors the use of
> mmap_rnd() to be used similarly to arm and x86. This additionally enables
> mmap ASLR on legacy mmap layouts, which appeared to be missing on arm64,
> and was already supported on arm. Additionally removes a copy/pasted
> declaration of an unused function.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/elf.h |  1 -
>  arch/arm64/mm/mmap.c         | 18 +++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)

Looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Do you want me to pick this up, or are you taking it along with the rest of
your series (it doesn't have any obvious dependencies to me)?

Will
