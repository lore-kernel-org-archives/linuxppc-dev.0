Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 033A11A072A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 03:24:39 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 16:24:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 01F2717D805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 16:24:59 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANGOYik1376552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 16:24:34 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANGOXvJ006178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 09:24:34 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
To: Ming Lei <ming.lei@canonical.com>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
 <1448021448.14769.7.camel@ellerman.id.au>
 <565055C6.5040801@linux.vnet.ibm.com> <20151122005635.1b9ffbe1@tom-T450>
 <1448234410.8209.3.camel@redhat.com> <56531B3F.60503@linux.vnet.ibm.com>
 <20151123151330.GA10990@dhcppc13.redhat.com>
 <56532EC7.3060000@linux.vnet.ibm.com>
 <CACVXFVMNed2Liarx9FA16CERNAepNYdNFhDpn70kb3RBt0eRuQ@mail.gmail.com>
Cc: Pratyush Anand <panand@redhat.com>, Mark Salter <msalter@redhat.com>,
 linux-block@vger.kernel.org,
 Linux SCSI List <linux-scsi@vgneitherer.kernel.org>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, brking <brking@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <56533DC1.5070505@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 17:24:33 +0100
MIME-Version: 1.0
In-Reply-To: <CACVXFVMNed2Liarx9FA16CERNAepNYdNFhDpn70kb3RBt0eRuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/11/2015 16:27, Ming Lei wrote:
> On Mon, Nov 23, 2015 at 11:20 PM, Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
>>>
>>> Reverting above commit on top if 4.4-rc1 seems to fix the problem for me.
>>
>> That's what I mentioned earlier ;)
>>
>> Now Ming send an additional patch with seems to fix the bug introduced
>> through the commit bdced438acd8. When testing with this new patch I
>> can't get the panic anymore, but Mark reported he is still hitting it.
> 
> Laurent, thanks for your test on the 1st patch, and looks there are at
> least two problems, and my 2nd patch sent just now should address
> Mark's issue which is caused by bdced438acd83a.
> 
> Once the 2nd one is tested OK, I will send out the two together.

FWIW, I applied the 2nd patch, and my system is still running like a charm.

Cheers,
Laurent.
