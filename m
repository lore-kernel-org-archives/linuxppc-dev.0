Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A1C60B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 08:41:09 +1100 (EST)
Received: by laam7 with SMTP id m7so1192144laa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 13:41:02 -0800 (PST)
Subject: Re: [PATCH v2] Integrated Flash Controller support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 29 Nov 2011 23:40:57 +0200
In-Reply-To: <8EDB3DC6-63E5-4D5C-BB52-15F32B85C5DD@kernel.crashing.org>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
 <CCF7C6DB-437C-4140-894F-2F497AD610DC@kernel.crashing.org>
 <8EDB3DC6-63E5-4D5C-BB52-15F32B85C5DD@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1322602860.2150.10.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "b35362@freescale.com>" <b35362@freescale.com>,
 "linux-kernel@vger.kernel.org Kernel" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-24 at 08:24 -0600, Kumar Gala wrote:
> On Nov 22, 2011, at 9:41 PM, Kumar Gala wrote:
> 
> > 
> > On Oct 31, 2011, at 4:38 AM, <b35362@freescale.com> <b35362@freescale.com> wrote:
> > 
> >> From: Liu Shuo <b35362@freescale.com>
> >> 
> >> Integrated Flash Controller supports various flashes like NOR, NAND
> >> and other devices using NOR, NAND and GPCM Machine available on it.
> >> IFC supports four chip selects.
> >> 
> >> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> >> Signed-off-by: Scott Wood <scottwood@freescale.com>
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> >> Signed-off-by: Liu Shuo <b35362@freescale.com>
> >> ---
> >> arch/powerpc/Kconfig               |    4 +
> >> arch/powerpc/include/asm/fsl_ifc.h |  834 ++++++++++++++++++++++++++++++++++++
> >> arch/powerpc/sysdev/Makefile       |    1 +
> >> arch/powerpc/sysdev/fsl_ifc.c      |  322 ++++++++++++++
> >> 4 files changed, 1161 insertions(+), 0 deletions(-)
> >> create mode 100644 arch/powerpc/include/asm/fsl_ifc.h
> >> create mode 100644 arch/powerpc/sysdev/fsl_ifc.c
> > 
> > Guys,
> > 
> > How are we handling this patchset since it touches drivers/mtd/nand?

I do not see it touching MTD from the diffstat above. I am a little bit
confused why a flash controller is added to
arch/powerpc/sysdev/fsl_ifc.c ?

Artem.
