Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id AEC41B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 23:17:55 +1000 (EST)
Message-ID: <4E5256F5.3090909@redhat.com>
Date: Mon, 22 Aug 2011 16:17:41 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<4E51F782.7060005@redhat.com> <20110822104635.GC2079@amd.com>
	<4E5234B7.7000700@redhat.com> <20110822123651.GD2079@amd.com>
	<4E524EBB.8090603@redhat.com> <20110822125502.GF2079@amd.com>
	<4E52543F.70104@redhat.com> <20110822131508.GG2079@amd.com>
In-Reply-To: <20110822131508.GG2079@amd.com>
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

On 08/22/2011 04:15 PM, Roedel, Joerg wrote:
> On Mon, Aug 22, 2011 at 09:06:07AM -0400, Avi Kivity wrote:
> >  On 08/22/2011 03:55 PM, Roedel, Joerg wrote:
>
> >  >  Well, I don't think its really meaningless, but we need some way to
> >  >  communicate the information about device groups to userspace.
> >
> >  I mean the contents of the group descriptor.  There are enough 42s in
> >  the kernel, it's better if we can replace a synthetic number with
> >  something meaningful.
>
> If we only look at PCI than a Segment:Bus:Dev.Fn Number would be
> sufficient, of course. But the idea was to make it generic enough so
> that it works with !PCI too.
>

We could make it an arch defined string instead of a symlink.  So it 
doesn't return 42, rather something that can be used by the admin to 
figure out what the problem was.

-- 
error compiling committee.c: too many arguments to function
