Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRKtP17j7zDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 05:41:00 +1100 (AEDT)
Message-ID: <1509475255.10233.140.camel@linux.intel.com>
Subject: Re: [PATCH v1] powerpc/pci: convert to use for_each_pci_bridge()
 helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: bjorn@helgaas.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 31 Oct 2017 20:40:55 +0200
In-Reply-To: <CABhMZUV0me+PG8daQ8iOzcSEJBQMD4=JGbMp7sVm_5CujwZ4eQ@mail.gmail.com>
References: <20171013165250.25370-1-andriy.shevchenko@linux.intel.com>
 <1509462750.10233.134.camel@linux.intel.com>
 <CABhMZUV0me+PG8daQ8iOzcSEJBQMD4=JGbMp7sVm_5CujwZ4eQ@mail.gmail.com>
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

On Tue, 2017-10-31 at 13:33 -0500, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2017 at 10:12 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, 2017-10-13 at 19:52 +0300, Andy Shevchenko wrote:
> > > ...which makes code slightly cleaner.
> > 
> > +Cc: Bjorn
> > 
> > Perhaps it makes sense to pass this through PCI if no one objects?
> 
> Fine with me, but I only apply things that appear on the
> linux-pci@vger.kernel.org mailing list.

I want to wait for powerpc maintainers to Ack and then I'll resend.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
