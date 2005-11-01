Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.193])
	by ozlabs.org (Postfix) with ESMTP id 982136866B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Nov 2005 09:51:37 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id n28so405627nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 01 Nov 2005 14:51:34 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Wed, 2 Nov 2005 00:55:57 +0200
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051101172524.GA5623@logos.cnet>
In-Reply-To: <20051101172524.GA5623@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511020055.58010.pantelis.antoniou@gmail.com>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 01 November 2005 19:25, Marcelo Tosatti wrote:
> On Sun, Oct 30, 2005 at 11:03:24PM +0300, Pantelis Antoniou wrote:
> > Latest MMU changes caused 8xx to stop working. Flushing tlb of the faulting
> > address fixes the problem.
> 
> Hi Panto,
> 
> Its working fine around here. How much of a vanilla 2.6.14 your is?
> 
> [root@CAS root]# cat /proc/cpuinfo
> processor       : 0
> cpu             : 8xx
> clock           : 48MHz
> bus clock       : 48MHz
> revision        : 0.0 (pvr 0050 0000)
> bogomips        : 47.82
> [root@CAS root]# uname -a
> Linux CAS 2.6.14 #2 Tue Nov 1 16:20:28 CST 2005 ppc unknown
> 
> 

Vanila 2.6.14 worked fine too.

It's the mm patches that started coming in later. 
Unfortunately the version did not change, so I can't provide it.
Did you used a current git tree?

Regards

Pantelis
