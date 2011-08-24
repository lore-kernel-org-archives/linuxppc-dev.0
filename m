Return-Path: <Joerg.Roedel@amd.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51DAAB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 19:14:48 +1000 (EST)
Date: Wed, 24 Aug 2011 11:14:26 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: aafabbri <aafabbri@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824091425.GE2079@amd.com>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CA792953.FB87%aafabbri@cisco.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
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

On Tue, Aug 23, 2011 at 12:54:27PM -0400, aafabbri wrote:
> On 8/23/11 4:04 AM, "Joerg Roedel" <joerg.roedel@amd.com> wrote:
> > That is makes uiommu basically the same as the meta-groups, right?
> 
> Yes, functionality seems the same, thus my suggestion to keep uiommu
> explicit.  Is there some need for group-groups besides defining sets of
> groups which share IOMMU resources?
> 
> I do all this stuff (bringing up sets of devices which may share IOMMU
> domain) dynamically from C applications.  I don't really want some static
> (boot-time or sysfs fiddling) supergroup config unless there is a good
> reason KVM/power needs it.
> 
> As you say in your next email, doing it all from ioctls is very easy,
> programmatically.

I don't see a reason to make this meta-grouping static. It would harm
flexibility on x86. I think it makes things easier on power but there
are options on that platform to get the dynamic solution too.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
