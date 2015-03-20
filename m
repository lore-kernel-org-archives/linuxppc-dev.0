Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2C8A1A09EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:30:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 21 Mar 2015 07:30:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 96E842BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:29:57 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KLTnwB45482206
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:29:57 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KLTO2F026377
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:29:24 +1100
Message-ID: <1426886935.4770.178.camel@au1.ibm.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 21 Mar 2015 08:28:55 +1100
In-Reply-To: <CAErSpo4vsw89bNbzJbqRiW4vy2Vzpmr-3DTdnUEhzUMPLUTn+g@mail.gmail.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150320054327.GA8119@shangw>
 <CAErSpo6zTLyDK+aaHK6+uwfs579Qq1vbXDx4rb9L4uNq=24dVA@mail.gmail.com>
 <1426885502.4770.159.camel@au1.ibm.com>
 <CAErSpo4vsw89bNbzJbqRiW4vy2Vzpmr-3DTdnUEhzUMPLUTn+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 16:16 -0500, Bjorn Helgaas wrote:
> 
> > The other option is you put the generic changes in a topic branch
> which
> > both of us merge and I take care of the rest.
> 
> Yeah, I chatted with Wei this morning, and he reminded me that there's
> really not very much drivers/pci content there.  So I think I can just
> ack those bits and you can take the whole thing.  I noticed some
> changelog typos I'll point out, then I'll be done.

Excellent, thanks.

Cheers,
Ben.
