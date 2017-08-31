Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjhhs4xjpzDrXQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:37:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <87y3q0hxtm.fsf@linux.vnet.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 22:37:13 +1000
Message-ID: <877exjud52.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>> OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
>> flip it back to being a module.
>
> Yeah. We tend to keep all RAID adapters as modules because they almost
> all uniquely try to undo all boot time optimization done by anybody,
> anywhere, ever.

Yes I know what you mean. I am thinking of one In ParticulaR.

cheers
