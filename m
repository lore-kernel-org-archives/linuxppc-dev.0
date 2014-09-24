Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E25F31A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 18:16:54 +1000 (EST)
Date: Tue, 23 Sep 2014 23:35:11 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 04/11] drivers: base: support cpu cache information
 interface to userspace via sysfs
Message-ID: <20140924063511.GA12929@kroah.com>
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
 <5419C3F6.4050607@arm.com> <20140917190048.GA4063@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140917190048.GA4063@kroah.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 17, 2014 at 12:00:48PM -0700, Greg Kroah-Hartman wrote:
> On Wed, Sep 17, 2014 at 06:25:10PM +0100, Sudeep Holla wrote:
> > Hi Greg,
> > 
> > On 03/09/14 18:00, Sudeep Holla wrote:
> > >From: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > >This patch adds initial support for providing processor cache information
> > >to userspace through sysfs interface. This is based on already existing
> > >implementations(x86, ia64, s390 and powerpc) and hence the interface is
> > >intended to be fully compatible.
> > >
> > >The main purpose of this generic support is to avoid further code
> > >duplication to support new architectures and also to unify all the existing
> > >different implementations.
> > >
> > >This implementation maintains the hierarchy of cache objects which reflects
> > >the system's cache topology. Cache devices are instantiated as needed as
> > >CPUs come online. The cache information is replicated per-cpu even if they are
> > >shared. A per-cpu array of cache information maintained is used mainly for
> > >sysfs-related book keeping.
> > >
> > >It also implements the shared_cpu_map attribute, which is essential for
> > >enabling both kernel and user-space to discover the system's overall cache
> > >topology.
> > >
> > >This patch also add the missing ABI documentation for the cacheinfo sysfs
> > >interface already, which is well defined and widely used.
> > >
> > 
> > Can you review the first 4 patches in this series please ?
> 
> It's in my todo queue, which is really long at the moment due to me
> going to conferences (at one right now...)  Will be working on this
> soon, thanks for your patience.

Based on the review comments, I think you are going to change at least
the first patch, right?  Please resend the latest version of this
series, with all of the accumulated tested-by and acked lines and
resend.

thanks,

greg k-h
