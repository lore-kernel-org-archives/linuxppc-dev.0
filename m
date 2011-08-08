Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 55E6CB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 18:29:22 +1000 (EST)
Message-ID: <4E3F9E33.5000706@redhat.com>
Date: Mon, 08 Aug 2011 11:28:35 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
In-Reply-To: <20110803020422.GF29719@yookeroo.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2011 05:04 AM, David Gibson wrote:
> I still don't understand the distinction you're making.  We're saying
> the group is "owned" by a given user or guest in the sense that no-one
> else may use anything in the group (including host drivers).  At that
> point none, some or all of the devices in the group may actually be
> used by the guest.
>
> You seem to be making a distinction between "owned by" and "assigned
> to" and "used by" and I really don't see what it is.
>

Alex (and I) think that we should work with device/function granularity, 
as is common with other archs, and that the group thing is just a 
constraint on which functions may be assigned where, while you think 
that we should work at group granularity, with 1-function groups for 
archs which don't have constraints.

Is this an accurate way of putting it?

-- 
error compiling committee.c: too many arguments to function
