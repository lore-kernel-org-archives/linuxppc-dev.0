Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B3271A0121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 18:25:18 +1000 (EST)
Date: Mon, 15 Sep 2014 09:34:20 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] PCI/MSI/PPC: Remove arch_msi_check_device()
Message-ID: <20140915083418.GC8793@agordeev.usersys.redhat.com>
References: <cover.1410078503.git.agordeev@redhat.com>
 <a7a806c4f531ba80386e9d0baf69571a827ea59c.1410078503.git.agordeev@redhat.com>
 <1410748970.24738.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410748970.24738.3.camel@concordia>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 15, 2014 at 12:42:50PM +1000, Michael Ellerman wrote:
> On Sun, 2014-09-07 at 20:57 +0200, Alexander Gordeev wrote:
> > Moving MSI checks from arch_msi_check_device() function to
> > arch_setup_msi_irqs() function makes code more compact and
> > allows removing unnecessary hook arch_msi_check_device()
> > from generic MSI code.
> > 
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pci@vger.kernel.org
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> 
> I already acked the previous version, but if you didn't want it that's fine :)

I do want it, but I thought you may not agree with the new changelog ;)

> cheers
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
