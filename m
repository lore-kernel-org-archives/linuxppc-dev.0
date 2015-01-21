Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD5E11A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:55:26 +1100 (AEDT)
Date: Wed, 21 Jan 2015 14:55:25 +1100
From: Anton Blanchard <anton@samba.org>
To: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH 3/3] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
Message-ID: <20150121145525.49c9510b@kryten>
In-Reply-To: <54AD4C1C.60505@akamai.com>
References: <1420626958-31254-1-git-send-email-anton@samba.org>
 <1420626958-31254-3-git-send-email-anton@samba.org>
 <54AD4C1C.60505@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "liuj97@gmail.com" <liuj97@gmail.com>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mmarek@suse.cz" <mmarek@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jason,

> > diff --git a/arch/powerpc/platforms/pseries/lpar.c
> > b/arch/powerpc/platforms/pseries/lpar.c index 469751d..14ac1ad
> > 100644 --- a/arch/powerpc/platforms/pseries/lpar.c
> > +++ b/arch/powerpc/platforms/pseries/lpar.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/console.h>
> >  #include <linux/export.h>
> >  #include <linux/static_key.h>
> > +#include <linux/jump_label.h>
> >  #include <asm/processor.h>
> >  #include <asm/mmu.h>
> >  #include <asm/page.h>
> 
> You can drop the 'static_key.h' include here since its redundant.

Thanks, I incorporated this into the next series.

Anton
