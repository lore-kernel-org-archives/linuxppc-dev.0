Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fx7N2MY1zF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 18:35:27 +1000 (AEST)
Date: Wed, 27 Jun 2018 11:34:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
 <20180626074426.hzunfbvwbubt3t3p@mwanda>
 <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2018 at 10:34:54AM +0800, Pingfan Liu wrote:
> > 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> > 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> > 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
> >
> > If the list is empty then "ret" can be unitialized.  We test a different
> > list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> > code to make Smatch try to understand about empty lists, but I don't
> > think it works...
> >
> Yes, if list_empty, then the code can not touch ret. But ret is
> useless in this scene. Does it matter?
> 

I'm not sure I understand what you're asking?  Of course, it matters?

regards,
dan carpenter
