Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53194B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 22:55:11 +1000 (EST)
Date: Mon, 22 Aug 2011 14:55:02 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Avi Kivity <avi@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110822125502.GF2079@amd.com>
References: <20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home> <4E51F782.7060005@redhat.com>
	<20110822104635.GC2079@amd.com> <4E5234B7.7000700@redhat.com>
	<20110822123651.GD2079@amd.com> <4E524EBB.8090603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4E524EBB.8090603@redhat.com>
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

On Mon, Aug 22, 2011 at 08:42:35AM -0400, Avi Kivity wrote:
> On 08/22/2011 03:36 PM, Roedel, Joerg wrote:
> > On the AMD IOMMU side this information is stored in the IVRS ACPI table.
> > Not sure about the VT-d side, though.
> 
> I see.  There is no sysfs node representing it?

No. It also doesn't exist as a 'struct pci_dev'. This caused problems in
the AMD IOMMU driver in the past and I needed to fix that. There I know
that from :)

> I'd rather not add another meaningless identifier.

Well, I don't think its really meaningless, but we need some way to
communicate the information about device groups to userspace.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
