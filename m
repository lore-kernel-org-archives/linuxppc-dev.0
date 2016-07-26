Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7911qwRzDrKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:13:25 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id x72so71951608pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 23:13:25 -0700 (PDT)
Date: Tue, 26 Jul 2016 16:13:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/9] Add #defs for paca->soft_enabled flags
Message-ID: <20160726161315.3b1c6841@roar.ozlabs.ibm.com>
In-Reply-To: <1ee595c7-2c1e-82f4-4d1b-33fa9074c545@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726152706.43bffd08@roar.ozlabs.ibm.com>
 <1ee595c7-2c1e-82f4-4d1b-33fa9074c545@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2016 11:35:16 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Tuesday 26 July 2016 10:57 AM, Nicholas Piggin wrote:
> > On Mon, 25 Jul 2016 20:22:14 +0530
> > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> >  
> >> Two #defs LAZY_INTERRUPT_ENABLED and
> >> LAZY_INTERRUPT_DISABLED are added to be used
> >> when updating paca->soft_enabled.  
> > This is a very nice patchset, but can this not be a new name?  
> 
> Thanks, but idea is from ben :)
> Regarding the name, I looked at the initial patchset posted by
> paul and took the name from it :).
> 
> But will work on that, any suggestion for the name?

I don't have a strong preference. LAZY_* is not horrible itself,
it's just that softe variant is used elsewhere. I don't mind if
you rename softe to something else completely (although Ben might).
Allow me to apply the first coat of paint to the bikeshed:

irq_disable_level

IRQ_DISABLE_LEVEL_NONE
IRQ_DISABLE_LEVEL_LINUX
IRQ_DISABLE_LEVEL_PMU
