Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 47671B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 22:43:20 +1000 (EST)
Message-ID: <4E524EBB.8090603@redhat.com>
Date: Mon, 22 Aug 2011 15:42:35 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<4E51F782.7060005@redhat.com> <20110822104635.GC2079@amd.com>
	<4E5234B7.7000700@redhat.com> <20110822123651.GD2079@amd.com>
In-Reply-To: <20110822123651.GD2079@amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2011 03:36 PM, Roedel, Joerg wrote:
> On Mon, Aug 22, 2011 at 06:51:35AM -0400, Avi Kivity wrote:
> >  On 08/22/2011 01:46 PM, Joerg Roedel wrote:
> >  >  That does not work. The bridge in question may not even be visible as a
> >  >  PCI device, so you can't link to it. This is the case on a few PCIe
> >  >  cards which only have a PCIx chip and a PCIe-2-PCIx bridge to implement
> >  >  the PCIe interface (yes, I have seen those cards).
> >
> >  How does the kernel detect that devices behind the invisible bridge must
> >  be assigned as a unit?
>
> On the AMD IOMMU side this information is stored in the IVRS ACPI table.
> Not sure about the VT-d side, though.
>

I see.  There is no sysfs node representing it?

I'd rather not add another meaningless identifier.

-- 
error compiling committee.c: too many arguments to function
