Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.207])
	by ozlabs.org (Postfix) with ESMTP id B5FAA2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 23:00:01 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4695449rnk
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 02 Oct 2004 05:59:59 -0700 (PDT)
Message-ID: <35fb2e59041002055952ae54a7@mail.gmail.com>
Date: Sat, 2 Oct 2004 13:59:59 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1096691732.11996.6.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<1096602008.14803.16.camel@gaston> <415D3C2C.7050704@jonmasters.org>
	<35fb2e590410011454270f2698@mail.gmail.com>
	<1096691732.11996.6.camel@gaston>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 02 Oct 2004 14:35:32 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> bi_recs have been removed completely from ppc64.

Sorry. I was getting confused by old references in the prom_init stuff
in 2.6.8.1 and couldn't see how it handled systems without OF - but I
was looking at this the wrong way around.

> head.S explains how the entry is done.

Yeah. I hadn't looked at how this is actually linked together (I don't
have ppc64 myself remember so I'm just getting up to speed on which bk
tree is which and so on at this stage). I can clearly see the
multiplatform entry stuff now so thanks. It might help for me to build
a kernel and look at it with objdump (which is what I usually do to
figure out layouts).

> You can enter the kernel with r5=NULL if
> you provide the flattened device-tree in r3.

I'll get there. Just need a bit of time to get familiar with the code
- I'll probably followup with annoying questions later on in the early
hours UK time :-).

Jon.
