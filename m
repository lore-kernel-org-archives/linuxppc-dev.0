Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45AE81A075B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 04:42:21 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Mon, 9 Mar 2015 17:42:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 304E91B08061
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 17:42:36 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29HgGXP47906880
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 17:42:16 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29Hg5fZ024891
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 11:42:15 -0600
Date: Mon, 9 Mar 2015 10:42:03 -0700
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 08/10] s390: redefine randomize_et_dyn for
 ELF_ET_DYN_BASE
Message-ID: <20150309104203.7767babc@mschwide>
In-Reply-To: <1425503454-7531-9-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-9-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, Min-Hua Chen <orca.chen@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Arun Chandran <achandran@mvista.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, Oleg Nesterov <oleg@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?UTF-8?B?TcO2bGxlcg==?= <dl9pf@gmx.de>,
 linux-fsdevel@vger.kernel.org, linux390@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  4 Mar 2015 13:10:52 -0800
Kees Cook <keescook@chromium.org> wrote:

> In preparation for moving ET_DYN randomization into the ELF loader (which
> requires a static ELF_ET_DYN_BASE), this redefines s390's existing ET_DYN
> randomization in a call to arch_mmap_rnd(). This refactoring results in
> the same ET_DYN randomization on s390.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/include/asm/elf.h |  8 +++++---
>  arch/s390/mm/mmap.c         | 11 ++---------
>  2 files changed, 7 insertions(+), 12 deletions(-)

Patch series including this patch works fine
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
