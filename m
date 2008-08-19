Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 087C8DE1ED
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 22:03:07 +1000 (EST)
Received: by gxk14 with SMTP id 14so4643153gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 05:03:05 -0700 (PDT)
Subject: Re: [PATCH 1/4] kvmppc: read device tree hypervisor node
	infrastructure
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: ehrhardt@linux.vnet.ibm.com
In-Reply-To: <1219146725.26429.3.camel@jdub.homelinux.org>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-2-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219146725.26429.3.camel@jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 07:56:02 -0400
Message-Id: <1219146962.26429.5.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-19 at 07:52 -0400, Josh Boyer wrote:
> On Tue, 2008-08-19 at 12:36 +0200, ehrhardt@linux.vnet.ibm.com wrote:
> > diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/kvm.c
> > @@ -0,0 +1,30 @@
> 
> > +#include <linux/percpu.h>
> > +#include <linux/mm.h>
> > +#include <linux/kvm_para.h>
> > +
> > +void __init kvm_guest_init(void)
> > +{
> > +	if (!kvm_para_available())
> > +		return;
> > +}
> 
> This looks really odd.  You have a void function that checks the return
> value of another function and returns if not true or.. returns if true.
> Why bother with the if at all?

Nevermind.  I see you add more code below this in patch 3.  Still looks
odd by itself, but makes more sense when the whole series is applied.

josh
