Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 27677B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 00:40:26 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so2270306vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2011 05:40:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
 <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
Date: Fri, 9 Dec 2011 08:40:22 -0500
Message-ID: <CA+5PVA7+73myrEGDUjuYrc2D-MabCefehpV+ynpOPFi=hLRMEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] [ppc] Process dynamic relocations for kernel
From: Josh Boyer <jwboyer@gmail.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 9, 2011 at 6:47 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote=
:
>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Alan Modra <amodra@au1.ibm.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> ---
>
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 42 +++++++++++++=
+++++++++---------------
> =A0arch/powerpc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +++--
> =A0arch/powerpc/kernel/Makefile =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/powerpc/kernel/vmlinux.lds.S | =A0 =A08 ++++++-
> =A0arch/powerpc/relocs_check.pl =A0 =A0 =A0| =A0 =A07 ++++++
> =A05 files changed, 44 insertions(+), 21 deletions(-)

You're missing the whole reloc_32.S file in this patch.  Forget to do a git=
-add?

Can you resend just this patch with that fixed up?

josh
