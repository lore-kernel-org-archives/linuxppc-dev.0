Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 126831A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 12:30:18 +1100 (AEDT)
Message-ID: <1448328614.8209.45.camel@redhat.com>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
From: Mark Salter <msalter@redhat.com>
To: Ming Lei <ming.lei@canonical.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, linux-block@vger.kernel.org, Linux
 SCSI List <linux-scsi@vger.kernel.org>, "James E. J. Bottomley"
 <JBottomley@odin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, brking <brking@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 Nov 2015 20:30:14 -0500
In-Reply-To: <CACVXFVMNed2Liarx9FA16CERNAepNYdNFhDpn70kb3RBt0eRuQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 23:27 +0800, Ming Lei wrote:
> On Mon, Nov 23, 2015 at 11:20 PM, Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
> > > 
> > > Reverting above commit on top if 4.4-rc1 seems to fix the problem for me.
> > 
> > That's what I mentioned earlier ;)
> > 
> > Now Ming send an additional patch with seems to fix the bug introduced
> > through the commit bdced438acd8. When testing with this new patch I
> > can't get the panic anymore, but Mark reported he is still hitting it.
> 
> Laurent, thanks for your test on the 1st patch, and looks there are at
> least two problems, and my 2nd patch sent just now should address
> Mark's issue which is caused by bdced438acd83a.
> 
> Once the 2nd one is tested OK, I will send out the two together.
> 
> Thanks,
> Ming

Thanks Ming.
With both patches applied, I have been unable to reproduce the problem.
