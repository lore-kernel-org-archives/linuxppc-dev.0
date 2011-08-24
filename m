Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C574FB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 21:06:01 +1000 (EST)
Date: Wed, 24 Aug 2011 13:03:32 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Mackerras
	<pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>, iommu
	<iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>, Anthony
	Liguori <anthony@codemonkey.ws>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, "benve@cisco.com" <benve@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824110332.GH2079@amd.com>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
	<20110824093300.GI30097@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110824093300.GI30097@yookeroo.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2011 at 05:33:00AM -0400, David Gibson wrote:
> On Wed, Aug 24, 2011 at 11:14:26AM +0200, Roedel, Joerg wrote:

> > I don't see a reason to make this meta-grouping static. It would harm
> > flexibility on x86. I think it makes things easier on power but there
> > are options on that platform to get the dynamic solution too.
> 
> I think several people are misreading what Ben means by "static".  I
> would prefer to say 'persistent', in that the meta-groups lifetime is
> not tied to an fd, but they can be freely created, altered and removed
> during runtime.

Even if it can be altered at runtime, from a usability perspective it is
certainly the best to handle these groups directly in qemu. Or are there
strong reasons to do it somewhere else?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
