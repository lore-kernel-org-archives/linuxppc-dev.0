Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 194551A0013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 23:56:56 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 20 Nov 2015 12:56:53 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E4FF17D805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 12:57:13 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAKCuo6x59899942
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 12:56:50 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAKCun0L001208
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 05:56:49 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Hellwig <hch@infradead.org>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
 <1448021448.14769.7.camel@ellerman.id.au>
Cc: Mark Salter <msalter@redhat.com>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 brking <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <564F188F.4080502@linux.vnet.ibm.com>
Date: Fri, 20 Nov 2015 13:56:47 +0100
MIME-Version: 1.0
In-Reply-To: <1448021448.14769.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/11/2015 13:10, Michael Ellerman wrote:
> On Thu, 2015-11-19 at 00:23 -0800, Christoph Hellwig wrote:
> 
>> It's pretty much guaranteed a block layer bug, most likely in the
>> merge bios to request infrastucture where we don't obey the merging
>> limits properly.
>>
>> Does either of you have a known good and first known bad kernel?
> 
> Not me, I've only hit it one or two times. All I can say is I have hit it in
> 4.4-rc1.
> 
> Laurent, can you narrow it down at all?

I'm trying bisect it but it's very time consuming, and I think I missed
some bad kernel because I didn't let enough time to the system to panic.

But I'm still on...

Cheers
