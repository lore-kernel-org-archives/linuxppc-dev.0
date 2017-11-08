Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yX6Zg1Zx6zDqnt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 00:28:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, bjorn@helgaas.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1] powerpc/pci: convert to use for_each_pci_bridge()
 helper
In-Reply-To: <1510059242.25007.81.camel@linux.intel.com>
References: <20171013165250.25370-1-andriy.shevchenko@linux.intel.com>
 <1509462750.10233.134.camel@linux.intel.com>
 <CABhMZUV0me+PG8daQ8iOzcSEJBQMD4=JGbMp7sVm_5CujwZ4eQ@mail.gmail.com>
 <1509475255.10233.140.camel@linux.intel.com>
 <1510059242.25007.81.camel@linux.intel.com>
Date: Thu, 09 Nov 2017 00:28:53 +1100
Message-ID: <87a7zw3nmy.fsf@concordia.ellerman.id.au>
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

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, 2017-10-31 at 20:40 +0200, Andy Shevchenko wrote:
>> On Tue, 2017-10-31 at 13:33 -0500, Bjorn Helgaas wrote:
>> > On Tue, Oct 31, 2017 at 10:12 AM, Andy Shevchenko
>> > <andriy.shevchenko@linux.intel.com> wrote:
>> > > On Fri, 2017-10-13 at 19:52 +0300, Andy Shevchenko wrote:
>> > > > ...which makes code slightly cleaner.
>> > > 
>> > > +Cc: Bjorn
>> > > 
>> > > Perhaps it makes sense to pass this through PCI if no one objects?
>> > 
>> > Fine with me, but I only apply things that appear on the
>> > linux-pci@vger.kernel.org mailing list.
>> 
>> I want to wait for powerpc maintainers to Ack and then I'll resend.
>
> Michael, Paul, Benjamin, do you have any concerns on this patch?

No, assuming it does what it says :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
