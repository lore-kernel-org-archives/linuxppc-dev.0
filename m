Return-Path: <greg@kroah.com>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19BE4B6FE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:31:34 +1000 (EST)
Date: Thu, 9 Jun 2011 13:31:17 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Message-ID: <20110609203117.GB14235@kroah.com>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF12A94.6070605@freescale.com>
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, akpm@kernel.org, linux-console@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2011 at 03:18:28PM -0500, Timur Tabi wrote:
> > More importantly, the code you have chose (0) conflicts with existing drivers
> > (frame buffer, scsi and wavefront among others). Please chose a free one and
> > add it to Documentation/ioctl/ioctl-number.txt in the same patch.
> 
> Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
> is important, and changing the type will break my existing apps.  Are you
> insisting that I pick a new number?

Why is binary compatibility important?  Isn't this a brand new driver
for a brand new system?  What userspace tools are out there in the wild
for such a thing?

confused,

greg k-h
