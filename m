Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 231D6B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 20:51:52 +1000 (EST)
Message-ID: <4E5234B7.7000700@redhat.com>
Date: Mon, 22 Aug 2011 13:51:35 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<4E51F782.7060005@redhat.com> <20110822104635.GC2079@amd.com>
In-Reply-To: <20110822104635.GC2079@amd.com>
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

On 08/22/2011 01:46 PM, Joerg Roedel wrote:
> >  $ readlink /sys/devices/pci0000:00/0000:00:19.0/iommu_group
> >  ../../../path/to/device/which/represents/the/resource/constraint
> >
> >  (the pci-to-pci bridge on x86, or whatever node represents partitionable
> >  endpoints on power)
>
> That does not work. The bridge in question may not even be visible as a
> PCI device, so you can't link to it. This is the case on a few PCIe
> cards which only have a PCIx chip and a PCIe-2-PCIx bridge to implement
> the PCIe interface (yes, I have seen those cards).
>

How does the kernel detect that devices behind the invisible bridge must 
be assigned as a unit?

-- 
error compiling committee.c: too many arguments to function
