Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3E151A004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 05:07:11 +1000 (EST)
Date: Sun, 7 Sep 2014 21:07:00 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/MSI: Remove arch_msi_check_device()
Message-ID: <20140907190659.GA23249@dhcp-27-160.brq.redhat.com>
References: <cover.1405160163.git.agordeev@redhat.com>
 <20140905212528.GG8080@google.com>
 <CAErSpo4XN01hgTUpcca=i-=LFV_bM-Cok8614LJzrOfVbx8MAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4XN01hgTUpcca=i-=LFV_bM-Cok8614LJzrOfVbx8MAA@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 03:27:49PM -0600, Bjorn Helgaas wrote:
> > I applied these (with Michael's ack on the first, and v2 of the second) to
> > pci/msi for v3.18, thanks!

Hi Bjorn,

I resent a series with updates that fix kbuild robot errors.
Hopefully, the rebase for pci/msi would not cause trouble for anyone.

> Oh, I forgot -- if you'd rather take the first one through the PPC
> tree, you can do that and I can merge the second one later.  Let me
> know if you want to do that.

Nah, your treee is just fine.

Thanks!

> Bjorn

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
