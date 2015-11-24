Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E5E91A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 08:25:40 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 19:25:36 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 53E131DC0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:25:30 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOLQ4V94673568
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 19:26:04 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOLPV92030745
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 19:25:32 -0200
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <5639F34F.5020402@linux.vnet.ibm.com> <20151124212341.GC17377@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, mst@redhat.com, shangw@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5654D5CA.4000607@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 19:25:30 -0200
MIME-Version: 1.0
In-Reply-To: <20151124212341.GC17377@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/2015 07:23 PM, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2015 at 10:00:15AM -0200, Guilherme G. Piccoli wrote:
>> Bjorn, ping?
>
> Sorry, Guilherme, this dropped off my radar, and I can't remember why.
> I'll take a look at it soon.
>
> Bjorn
>

Thanks very much Bjorn!
Sorry to bother, by the way.

Cheers,


Guilherme
